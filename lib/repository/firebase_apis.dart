import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rich_co_inventory/models/brand.dart';

abstract class FireStoreAPIs<T> {
  FireStoreAPIs() : instance = FirebaseFirestore.instance;
  final FirebaseFirestore instance;
  String get mainCollection;

  String get dependantCollection;
  add(T item);
  Future<bool> checkPath(
      {required String collection, required String id}) async {
    try {
      final res = instance.collection(collection).doc(id);
      final data = await res.get();
      return data.exists;
    } catch (e) {
      return false;
    }
  }

  Future<bool> check(
      {required String collection,
      required String column,
      required String arg}) async {
    final res = await instance
        .collection(collection)
        .where(column, isEqualTo: arg)
        .limit(1)
        .get();
    return res.docs.isNotEmpty;
  }

  delete(T item);
  update(T item);
  Future<T?> getOne(String name);
  Future<List<T>> getAll();
}

enum Collections { brands, suppliers, products ,sales, purchase, stock}
