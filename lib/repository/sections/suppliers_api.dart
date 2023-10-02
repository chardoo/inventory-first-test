import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rich_co_inventory/models/supplier.dart';
import 'package:rich_co_inventory/repository/firestore_apis.dart';

class SuppliersApis extends FireStoreAPIs<Supplier> {
  @override
  Future<({String? error, bool isError})> add(item) async {
    final supplier = Supplier.generateId(item.toJson());

    try {
      final isProductExist =
          await checkPath(collection: mainCollection, id: supplier.supplierId!);
      if (isProductExist) {
        return (isError: true, error: "product already exist");
      }
      instance
          .collection(mainCollection)
          .doc(supplier.supplierId)
          .set(supplier.toJson());
      return (isError: false, error: null);
    } on FirebaseException catch (e) {
      return (isError: true, error: e.message ?? "something occured");
    }
  }

  @override
  Future<({bool isError, String? error})> delete(Supplier item) async {
    try {
      final isConnectedToProduct = await check(
          collection: dependantCollection,
          field: "supplierId",
          arg: item.supplierId!);
      if (isConnectedToProduct) {
        return (
          isError: true,
          error: "This Supplier is connected to a product"
        );
      } else {
        final res = await instance
            .collection(mainCollection)
            .doc(item.supplierId)
            .get();
        await res.reference.delete();
        return (isError: false, error: null);
      }
    } on FirebaseException catch (e) {
      return (isError: true, error: e.message ?? "something occured");
    }
  }

  @override
  Future<({bool isError, String? error})> update(Supplier item) async {
    try {
      await instance
          .collection(mainCollection)
          .doc(item.supplierId)
          .update(item.toJson());
      return (isError: false, error: null);
    } on FirebaseException catch (e) {
      print("error ${e.message}");
      return (
        isError: true,
        error: e.message ?? "something occured at the server"
      );
    }
  }

  @override
  String get dependantCollection => Collections.products.name;

  @override
  String get mainCollection => Collections.suppliers.name;

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
