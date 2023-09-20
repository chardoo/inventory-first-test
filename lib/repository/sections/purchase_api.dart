import 'package:rich_co_inventory/models/purchase.dart';
import 'package:rich_co_inventory/repository/firestore_apis.dart';

class ProductApis extends FireStoreAPIs<Purchase> {
  @override
  String get mainCollection => Collections.products.name;

  @override
  String get dependantCollection => "";

  @override
  add(Purchase item) async {
    try {
      final isProductExist =
          await checkPath(collection: mainCollection, id: item.purchaseId);
      if (isProductExist) {
        //TODO: prevent user from adding
      } else {
        instance
            .collection(mainCollection)
            .doc(item.purchaseId)
            .set(item.toJson());
      }
    } catch (e) {}
  }

  @override
  delete(Purchase item) async {
    try {
      final hasConnectionToSales = await check(
          collection: dependantCollection,
          field: "purchaseId",
          arg: item.productId);

      if (hasConnectionToSales) {
        //TODO: cant delete product
      } else {
        final docToDelete =
            instance.collection(dependantCollection).doc(item.purchaseId);
        docToDelete.delete();
      }
    } catch (e) {
      print("error is $e");
    }
  }

  @override
  update(Purchase product) async {
    try {
      await instance
          .collection(mainCollection)
          .doc(product.purchaseId)
          .update(product.toJson());
    } catch (e) {
      //TODO: do something
    }
  }

  @override
  Future<Purchase?> getOne(String name) async {
    try {
      final res = await instance.collection(mainCollection).doc(name).get();
      if (res.exists) {
        return Purchase.fromJson(res.data()!);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<Purchase>> getAll() async {
    try {
      final res = await instance.collection(mainCollection).get();
      if (res.docs.isEmpty) return [];
      return res.docs.map((e) => Purchase.fromJson(e.data())).toList();
    } catch (e) {
      return [];
    }
  }
}
