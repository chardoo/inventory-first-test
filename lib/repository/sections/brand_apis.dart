import 'package:rich_co_inventory/repository/firestore_apis.dart';

import '../../models/brand.dart';

class BrandAPIs extends FireStoreAPIs<Brand> {
  @override
  String get mainCollection => "brands";

  @override
  String get dependantCollection => "products";

  @override
  add(Brand brand) async {
    try {
      final isBrandExist = await check(
          collection: mainCollection, field: "brandName", arg: brand.brandName);
      if (isBrandExist) {
        //TODO: prevent user from adding
        print("already exist");
      } else {
        instance.collection(mainCollection).add(brand.toJson());
      }
    } catch (e) {}
  }

  @override
  delete(Brand brand) async {
    try {
      final isConnectedToProduct = await check(
          collection: dependantCollection,
          field: "brandId",
          arg: brand.brandName);
      if (isConnectedToProduct) {
        //TODO: cant delete product
      } else {
        final docToDelete =
            instance.collection(dependantCollection).doc(brand.brandName);
        docToDelete.delete();
      }
    } catch (e) {
      print("error is $e");
    }
  }

  @override
  update(Brand brand) async {
    try {
      await instance
          .collection(mainCollection)
          .doc(brand.brandName)
          .update(brand.toJson());
    } catch (e) {
      //TODO: do something
    }
  }

  @override
  Future<Brand?> getOne(String brandName) async {
    try {
      final res =
          await instance.collection(mainCollection).doc(brandName).get();
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
