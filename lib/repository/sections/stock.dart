import 'package:rich_co_inventory/models/product.dart';
import 'package:rich_co_inventory/models/stock.dart';
import 'package:rich_co_inventory/repository/firestore_apis.dart';
import 'package:rich_co_inventory/repository/sections/product_apis.dart';

class StockApis extends FireStoreAPIs<Stock> {
  @override
  String get mainCollection => Collections.stock.name;

  @override
  String get dependantCollection => "";

  @override
  Future<String?> add(Stock item) async {
    final stock = Stock.generateId(item.toJson());

    try {
      final isProductExist =
          await checkPath(collection: mainCollection, id: stock.stockId ?? "");
      if (isProductExist) {
        //TODO: prevent user from adding
      } else {
        await instance
            .collection(mainCollection)
            .doc(stock.stockId)
            .set(stock.toJson());
        return stock.stockId;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  delete(Stock item) async {
    try {
      final docToDelete = instance.collection(mainCollection).doc(item.stockId);
      docToDelete.delete();
    } catch (e) {
      print("error is $e");
    }
  }

  @override
  update(Stock item) {}

  updateStock(Stock item, int dateInMilliseconds) async {
    try {
      final batch = instance.batch();
      final res = await instance
          .collection(mainCollection)
          .where("productId", isEqualTo: item.productId)
          .limit(1)
          .get();
      if (res.docs.isEmpty) {
        return null;
      }
      final productRef =
          await instance.collection("products").doc(item.productId).get();
      var product = Product.fromJson(productRef.data()!);

      product = product.copyWith(expiryDate: dateInMilliseconds);

      batch.update(productRef.reference, product.toJson());
      batch.update(res.docs.first.reference, item.toJson());
      batch.commit();
      return "success";
    } catch (e) {
      //TODO: do something
    }
  }

  Future<List<Stock?>> getStockByProductId(String productId) async {
    try {
      print("product id $productId");
      var res = await instance
          .collection(mainCollection)
          .where("productId", isEqualTo: productId)
          .get();

      if (res.docs.isEmpty) return [];
      return res.docs.map((e) => Stock.fromJson(e.data())).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<Stock?> getOne(String name) async {
    try {
      final res = await instance.collection(mainCollection).doc(name).get();
      if (res.exists) {
        return Stock.fromJson(res.data()!);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<Stock>> getAll() async {
    try {
      final res = await instance.collection(mainCollection).get();
      if (res.docs.isEmpty) return [];
      return res.docs.map((e) => Stock.fromJson(e.data())).toList();
    } catch (e) {
      return [];
    }
  }

  Future<List<Stock>> getStockByProductName(String name) async {
    try {
      // final res = await instance.collection(mainCollection).get();
      final res = await instance
          .collection(mainCollection)
          .where('productName', isGreaterThanOrEqualTo: name.toLowerCase())
          .where('productName', isLessThanOrEqualTo: '${name.toLowerCase()}z')
          .get();
      if (res.docs.isEmpty) return [];
      return res.docs.map((e) => Stock.fromJson(e.data())).toList();
    } catch (e) {
      return [];
    }
  }
}
