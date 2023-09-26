import 'package:rich_co_inventory/models/product.dart';
import 'package:rich_co_inventory/models/sales.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part '.generated/sales_cart_provider.g.dart';

@riverpod
class SalesCartProvider extends _$SalesCartProvider {
  @override
  List<Sale> build() {
    return [];
  }

  add(Product product) {
    final sale = Sale(
        productId: product.productId ?? "",
        saleDate: DateTime.now().millisecondsSinceEpoch,
        quantitySold: 0,
        totalRevenue: 0,
        productName: product.productName,
        productPrice: product.price);
    final containsProduct =
        state.map((e) => e.productId).contains(product.productId);
    if (containsProduct) {
      return;
    }
    state.add(sale);
    state = [...state];
  }

  update(Sale sale) {
    final newState = state.map((e) {
      if (e.productId == sale.productId) return sale;
      return e;
    }).toList();
    state = [...newState];
  }

  remove(String productId) {
    state.removeWhere((element) => element.productId == productId);
    if (state.isNotEmpty) {
      ref.read(selectedSales.notifier).set(state.last);
    } else {
      ref.read(selectedSales.notifier).reset();
    }
    state = [...state];
  }
}

@riverpod
class SelectedSales extends _$SelectedSales {
  @override
  Sale? build() {
    return null;
  }

  set(Sale? product) {
    state = product;
  }

  update(
      {String? productId,
      int? saleDate,
      int? quentity,
      String? productName,
      double? price}) {
    state = Sale(
        productId: productId ?? state!.productId,
        saleDate: saleDate ?? state!.saleDate,
        saleId: state!.saleId,
        totalRevenue: state!.totalRevenue,
        sales: state!.sales,
        salesmanId: state!.salesmanId,
        productName: productName ?? state!.productName,
        quantitySold: quentity ?? state!.quantitySold,
        productPrice: price ?? state!.productPrice);
    ref.read(salesCartProvider.notifier).update(state!);
  }

  reset() {
    state = null;
  }
}
