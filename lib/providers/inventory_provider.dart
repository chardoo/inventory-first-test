import 'package:rich_co_inventory/models/brand.dart';
import 'package:rich_co_inventory/models/product.dart';
import 'package:rich_co_inventory/models/purchase.dart';
import 'package:rich_co_inventory/models/stock.dart';
import 'package:rich_co_inventory/models/supplier.dart';
import 'package:rich_co_inventory/repository/sections/product_apis.dart';
import 'package:rich_co_inventory/repository/sections/purchase_api.dart';
import 'package:rich_co_inventory/repository/sections/stock.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repository/sections/brand_apis.dart';
import '../repository/sections/suppliers_api.dart';
import 'app_state_provider.dart';
part '.generated/inventory_provider.g.dart';

@Riverpod(keepAlive: true)
class InventoryProvider extends _$InventoryProvider {
  @override
  PurchaseState build() {
    return PurchaseState(me: 23);
  }

  Future<List<Stock>> getInventory(String name) async {
    return await StockApis().getStockByProductName(name);
  }

  Future<String?> addInventory(Stock stock) async {
   // final id = PurchaseApis().add(purchase);

    var currentStock =
        await StockApis().getStockByProductId(stock.productId);
    print("current stock");
    print(currentStock);

    StockApis().update(Stock(
        stockId: currentStock[0]!.stockId,
        productId: currentStock[0]!.productId!,
        productName: stock.productName,
        currentQuantity:
            currentStock[0]!.currentQuantity + stock.currentQuantity,
        minimumRequiredQuantity: currentStock[0]!.minimumRequiredQuantity));

    return '';
  }
}

class PurchaseState {
  int? me;
  List<Purchase>? listpurchase;
  Purchase? purchas;
  PurchaseState({this.me, this.listpurchase, this.purchas});
}
