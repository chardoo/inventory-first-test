import 'package:firebase_core/firebase_core.dart';
import 'package:rich_co_inventory/repository/firestore_apis.dart';

import '../../models/brand.dart';

class BrandAPIs extends FireStoreAPIs<Brand> {
  @override
  String get mainCollection => "brands";

  @override
  String get dependantCollection => "products";

  @override
  add(Brand item) async {
    final brand = Brand.generateId(item.toJson());

    try {
      final isBrandExist = await check(
          collection: mainCollection, field: "brandName", arg: brand.brandId!);
      if (isBrandExist) {
        return;
      } else {
        instance
            .collection(mainCollection)
            .doc(brand.brandId)
            .set(brand.toJson());
      }
    } catch (e) {}
  }

  @override
  Future<({bool isError, String? error})> delete(Brand brand) async {
    try {
      final isConnectedToProduct = await check(
          collection: dependantCollection,
          field: "brandId",
          arg: brand.brandId!);
      if (isConnectedToProduct) {
        return (isError: true, error: "This brand is connected to a product");
      } else {
        final res =
            await instance.collection(mainCollection).doc(brand.brandId).get();
        await res.reference.delete();
        return (isError: false, error: null);
      }
    } on FirebaseException catch (e) {
      return (isError: true, error: e.message ?? "something occured");
    }
  }

  @override
  Future update(Brand brand) async {
    try {
      await instance
          .collection(mainCollection)
          .doc(brand.brandId)
          .update(brand.toJson());
    } catch (e) {
      //TODO: do something
    }
  }

  @override
  Future<Brand?> getOne(String brandId) async {
    try {
      print("brand id $brandId");
      final res = await instance.collection(mainCollection).doc(brandId).get();
      if (res.exists) {
        return Brand.fromJson(res.data()!);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<List<Brand>> searchByName(String name) async {
    try {
      final res = await instance
          .collection(mainCollection)
          .where('brandName', isGreaterThanOrEqualTo: name.toLowerCase())
          .where('brandName', isLessThanOrEqualTo: '${name.toLowerCase()}z')
          .limit(10)
          .get();
      if (res.docs.isEmpty) return [];
      return res.docs.map((e) => Brand.fromJson(e.data())).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<Brand>> getAll() async {
    try {
      final res = await instance.collection(mainCollection).get();
      if (res.docs.isEmpty) return [];
      return res.docs.map((e) => Brand.fromJson(e.data())).toList();
    } catch (e) {
      return [];
    }
  }
}
