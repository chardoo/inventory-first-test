import 'package:rich_co_inventory/models/sales.dart';
import 'package:rich_co_inventory/repository/firestore_apis.dart';

class ProductApis extends FireStoreAPIs<Sale> {
  @override
  String get mainCollection => Collections.products.name;

  @override
  String get dependantCollection => "";

  @override
  add(Sale item) async {
    try {
      final isProductExist =
          await checkPath(collection: mainCollection, id: item.saleId);
      if (isProductExist) {
        //TODO: prevent user from adding
      } else {
        instance.collection(mainCollection).doc(item.saleId).set(item.toJson());
      }
    } catch (e) {}
  }

  @override
  delete(Sale item) async {
    try {
      final docToDelete =
          instance.collection(dependantCollection).doc(item.saleId);
      docToDelete.delete();
    } catch (e) {
      print("error is $e");
    }
  }

  @override
  update(Sale item) async {
    try {
      await instance
          .collection(mainCollection)
          .doc(item.saleId)
          .update(item.toJson());
    } catch (e) {
      //TODO: do something
    }
  }

  @override
  Future<Sale?> getOne(String name) async {
    try {
      final res = await instance.collection(mainCollection).doc(name).get();
      if (res.exists) {
        return Sale.fromJson(res.data()!);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<Sale>> getAll() async {
    try {
      final res = await instance.collection(mainCollection).get();
      if (res.docs.isEmpty) return [];
      return res.docs.map((e) => Sale.fromJson(e.data())).toList();
    } catch (e) {
      return [];
    }
  }
}
