import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
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

  Future<({bool isError, String? data, String? error})> addAll(
      List<Sale> sales) async {
    WriteBatch batch = FirebaseFirestore.instance.batch();

    try {
      for (var val in sales) {
        final sale = Sale.generateId(val.toJson());
        final docRef = instance.collection(mainCollection).doc(sale.saleId);
        final stockRef = await instance
            .collection(dependantCollection)
            .where("productId", isEqualTo: sale.productId)
            .get();
        final oldStock = Stock.fromJson(stockRef.docs.first.data());
        if (oldStock.currentQuantity == 0 ||
            oldStock.currentQuantity < sale.quantitySold!) {
          return (
            isError: true,
            data: null,
            error: "insufficient stock for ${sale.productName}"
          );
        }
        final updateStock =
            stockRef.docs.map((e) => Stock.fromJson(e.data())).toList();
        final quantity = sale.quantitySold ?? 0;
        final data = {
          "currentQuantity": updateStock[0].currentQuantity - quantity
        };
        batch.update(stockRef.docs.first.reference, data);
        batch.set(docRef, sale.toJson());
      }
      await batch.commit();
      return (isError: false, data: "success", error: null);
    } on FirebaseException catch (e) {
      return (
        isError: true,
        data: null,
        error: e.message ?? 'there is a fault at our side'
      );
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
  Future<({bool isError, String? error})> delete(Sale item) async {
    try {
      final batch = instance.batch();
      final saleRef =
          await instance.collection(mainCollection).doc(item.saleId).get();
      final stockRef = await instance
          .collection(dependantCollection)
          .where("productId", isEqualTo: item.productId)
          .limit(1)
          .get();
      if (stockRef.docs.isEmpty) {
        return (isError: true, error: "Stock does not exit");
      }
      Stock stock = Stock.fromJson(stockRef.docs.first.data());
      final quentity = stock.currentQuantity + item.quantitySold!;
      stock = stock.copyWith(currentQuantity: quentity);
      batch.delete(saleRef.reference);
      batch.update(stockRef.docs.first.reference, stock.toJson());
      batch.commit();
      return (isError: false, error: null);
    } on FirebaseException catch (e) {
      return (isError: true, error: e.toString());
    }
  }

  Future<List<Sale>> getSalesForRange(DateTime? start, DateTime? end) async {
    try {
      var t = DateTime.now();
      List<int> days = [];
      DateTime currentDay = start ?? DateTime(t.year, t.month, t.day);
      final DateTime endDay = end ?? currentDay.add(const Duration(days: 1));
      days.add(currentDay.millisecondsSinceEpoch);
      while (currentDay.isBefore(endDay)) {
        days.add(currentDay.millisecondsSinceEpoch);
        currentDay = currentDay.add(const Duration(days: 1));
      }
      days.add(endDay.millisecondsSinceEpoch);
      print(days);
      days = days.toSet().toList();

      var res = await instance
          .collection(Collections.sales.name)
          .where("saleDate", whereIn: days)
          .get();

      if (res.docs.isEmpty) return [];
      return res.docs.map((e) => Sale.fromJson(e.data())).toList();
    } catch (e) {
      return [];
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
      print("object $e");
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
