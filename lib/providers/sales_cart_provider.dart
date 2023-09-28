import 'package:cloud_firestore/cloud_firestore.dart';
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
        time: Timestamp.fromDate(DateTime.now()).toString(),
        productId: product.productId ?? "",
        saleDate: DateTime.now().millisecondsSinceEpoch,
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

    state = [...state];
  }
}
