import 'package:rich_co_inventory/models/supplier.dart';
import 'package:rich_co_inventory/repository/firestore_apis.dart';

class SuppliersApis extends FireStoreAPIs<Supplier> {
  @override
  add(item) async {
    try {
      final isProductExist =
          await checkPath(collection: mainCollection, id: item.supplierName);
      if (isProductExist) {
        //TODO: do some thing
        return;
      }
      instance
          .collection(mainCollection)
          .doc(item.supplierName)
          .set(item.toJson());
      print("done");
    } catch (e) {
      //TODO
    }
  }

  @override
  delete(item) async {
    try {
      final hasDependant = await check(
          collection: dependantCollection,
          field: "supplierName",
          arg: item.supplierName);
      if (hasDependant) {
        //TODO:
        return;
      }
      instance.collection(mainCollection).doc(item.supplierName).delete();
    } catch (e) {
      //TODO;
    }
  }

  @override
  String get dependantCollection => Collections.products.name;

  @override
  String get mainCollection => Collections.suppliers.name;

  @override
  update(item) async {
    try {
      await instance
          .collection(mainCollection)
          .doc(item.supplierName)
          .update(item.toJson());
    } catch (e) {
      //TODO:
    }
  }

  @override
  Future<List<Supplier>> getAll() async {
    try {
      final res = await instance.collection(mainCollection).get();
      if (res.docs.isEmpty) return [];
      return res.docs.map((e) => Supplier.fromJson(e.data())).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<Supplier?> getOne(String modelName) async {
    try {
      final res =
          await instance.collection(mainCollection).doc(modelName).get();
      if (res.exists) {
        return Supplier.fromJson(res.data()!);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<List<Supplier>> searchByName(String name) async {
    try {
      final res = await instance
          .collection(mainCollection)
          .where('supplierName', isGreaterThanOrEqualTo: name.toLowerCase())
          .where('supplierName', isLessThanOrEqualTo: '${name.toLowerCase()}z')
          .get();
      if (res.docs.isEmpty) return [];

      final a = res.docs.map((e) => Supplier.fromJson(e.data())).toList();
      print("data is $a");
      return a;
    } catch (e) {
      return [];
    }
  }
}
