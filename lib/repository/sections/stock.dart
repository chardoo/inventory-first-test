import 'package:rich_co_inventory/models/stock.dart';
import 'package:rich_co_inventory/repository/firebase_apis.dart';

class ProductApis extends FireStoreAPIs<Stock> {
  @override
  String get mainCollection => Collections.stock.name;

  @override
  String get dependantCollection => "";

  @override
  add(Stock item) async {
    try {
      final isProductExist =
          await checkPath(collection: mainCollection, id: item.stockId);
      if (isProductExist) {
        //TODO: prevent user from adding
      } else {
        instance
            .collection(mainCollection)
            .doc(item.stockId)
            .set(item.toJson());
      }
    } catch (e) {}
  }

  @override
  delete(Stock item) async {
    try {
      final docToDelete =
          instance.collection(mainCollection).doc(item.stockId);
      docToDelete.delete();
    } catch (e) {
      print("error is $e");
    }
  }

  @override
  update(Stock item) async {
    try {
      await instance
          .collection(mainCollection)
          .doc(item.stockId)
          .update(item.toJson());
    } catch (e) {
      //TODO: do something
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
}
