import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rich_co_inventory/models/product.dart';
import 'package:rich_co_inventory/models/purchase.dart';
import 'package:rich_co_inventory/models/sales.dart';
import 'package:rich_co_inventory/models/stock.dart';
import 'package:rich_co_inventory/repository/sections/purchase_api.dart';
import 'package:rich_co_inventory/repository/sections/sales_apis.dart';
import 'package:rich_co_inventory/repository/sections/stock.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '.generated/sales_provider.g.dart';

@Riverpod(keepAlive: true)
class SalesProvider extends _$SalesProvider {
  @override
  SalesState build() {
    return SalesState(total: 23);
  }

  Future<List<Purchase>> getPurchases(String date) async {
    var resutl = await PurchaseApis().getPurchaseByDate(date);

    return resutl;
  }

  Future<List<Sale>> getSalesForDuration(DateTime? start, DateTime? end) async {
    final sales = await SalesApi().getSalesForRange(start, end);
    double total = 0.0;

    for (int i = 0; i < sales.length; i++) {
      total = total + (sales[i].productPrice * sales[i].quantitySold!);
    }

    state = SalesState(total: total);
    return sales;
  }

  Future<List<Sale>> getSalesForToday(DateTime? start, DateTime? end) async {
    final sales = await SalesApi().getSalesForRange(start, end);
    double todaysSales = 0.0;

    for (int i = 0; i < sales.length; i++) {
      todaysSales =
          todaysSales + (sales[i].productPrice * sales[i].quantitySold!);
    }

    state = SalesState(todaySale: todaysSales, weekSales: state.weekSales);
    return sales;
  }

  Future<List<Sale>> getSalesForWeek() async {
    final end = DateTime.now();
    final start = end.subtract(const Duration(days: 7));
    final sales = await SalesApi().getSalesForRange(start, end);
    double weeklySales = 0.0;
    print("sales $sales");
    for (int i = 0; i < sales.length; i++) {
      weeklySales =
          weeklySales + (sales[i].productPrice * sales[i].quantitySold!);
    }

    state = SalesState(todaySale: state.todaySale, weekSales: weeklySales);
    return sales;
  }

  Future<({String? error, bool isError})> delete(Sale sale) async {
    final res = await SalesApi().delete(sale);
    return res;
  }

  Future<String?> addPurchase(Purchase purchase) async {
    final res = await PurchaseApis().add(purchase);

    var currentStock =
        await StockApis().getStockByProductId(purchase.productId);
    StockApis().update(Stock(
        stockId: currentStock[0]!.stockId,
        productId: currentStock[0]!.productId,
        currentQuantity:
            currentStock[0]!.currentQuantity + purchase.quantityPurchased,
        minimumRequiredQuantity: currentStock[0]!.minimumRequiredQuantity));

    return res.data;
  }
}

class SalesState {
  final double? total;
  final double todaySale;
  final double weekSales;
  final List<Product>? listOfProduct;
  final Purchase? purchas;
  SalesState(
      {this.total,
      this.listOfProduct,
      this.purchas,
      this.todaySale = 0,
      this.weekSales = 0});
}

final dateProvider = StateProvider<({DateTime? start, DateTime? end})>(
    (ref) => (start: null, end: null));
