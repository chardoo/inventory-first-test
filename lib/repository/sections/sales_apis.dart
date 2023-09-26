import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rich_co_inventory/models/sales.dart';
import 'package:rich_co_inventory/models/stock.dart';
import 'package:rich_co_inventory/repository/firestore_apis.dart';
import 'package:rich_co_inventory/repository/sections/stock.dart';

class SalesApi extends FireStoreAPIs<Sale> {
  final StockApis stockApis;
  SalesApi() : stockApis = StockApis();
  @override
  String get mainCollection => Collections.sales.name;

  @override
  String get dependantCollection => Collections.stock.name;

  Future<String> addAll(List<Sale> sales) async {
    WriteBatch batch = FirebaseFirestore.instance.batch();

    try {
      for (var val in sales) {
        final sale = Sale.generateId(val.toJson());
        final docRef = instance.collection(mainCollection).doc(sale.saleId);
        final stockRef = await instance
            .collection(dependantCollection)
            .where("productId", isEqualTo: sale.productId)
            .get();

        final updateStock =
            stockRef.docs.map((e) => Stock.fromJson(e.data())).toList();
        final data = {
          "currentQuantity": updateStock[0].currentQuantity - sale.quantitySold
        };
        batch.update(stockRef.docs.first.reference, data);
        batch.set(docRef, sale.toJson());
      }
      await batch.commit();
      return "successfull";
    } on FirebaseException catch (e) {
      return e.message ?? "an error occured";
    }
  }

  @override
  add(Sale item) async {
    final sale = Sale.generateId(item.toJson());
    try {
      final res = await instance
          .collection(mainCollection)
          .doc(sale.saleId)
          .set(sale.toJson());

      print("success");
    } on FirebaseException catch (e) {
      print("error firebase $e");
    } catch (e) {
      //TODO:
      print("error $e");
    }
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

  // Future<List<Sale>> searchByName(String name) async {
  //   try {
  //     final res = await instance
  //         .collection(mainCollection)
  //         .where('supplierName', isGreaterThanOrEqualTo: name.toLowerCase())
  //         .where('supplierName', isLessThanOrEqualTo: '${name.toLowerCase()}z')
  //         .get();
  //     if (res.docs.isEmpty) return [];

  //     final a = res.docs.map((e) => Sale.fromJson(e.data())).toList();
  //     print("data is $a");
  //     return a;
  //   } catch (e) {
  //     return [];
  //   }
  // }
}
