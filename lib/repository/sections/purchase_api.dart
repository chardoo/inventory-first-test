import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rich_co_inventory/models/purchase.dart';
import 'package:rich_co_inventory/models/stock.dart';
import 'package:rich_co_inventory/repository/firestore_apis.dart';

class PurchaseApis extends FireStoreAPIs<Purchase> {
  @override
  String get mainCollection => Collections.purchases.name;

  @override
  String get dependantCollection => Collections.stock.name;

  @override
  Future<String?> add(Purchase item) async {
    final purchaseToAdd = Purchase.generateId(item.toJson());
    final batch = FirebaseFirestore.instance.batch();
    print(purchaseToAdd.product);
    try {
      final stockRef = await instance
          .collection(dependantCollection)
          .where("productId", isEqualTo: item.productId)
          .get();

      final purchaseRef =
          instance.collection(mainCollection).doc(purchaseToAdd.purchaseId);
      final stock = Stock.fromJson(stockRef.docs.first.data());

      batch.update(stockRef.docs.first.reference,
          {'currentQuantity': stock.currentQuantity + item.quantityPurchased});
      batch.set(purchaseRef, purchaseToAdd.toJson());
      batch.commit();

      return purchaseToAdd.purchaseId;
    } catch (e) {
      print("error happen pleas");
      print(e.toString());
    }
    return null;
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

  Future<List<Purchase>> getPurchaseByDate(String data) async {
    try {
      // final res = await instance.collection(mainCollection).get();
      var result = [];
      // final res = await instance.collection(mainCollection).get().then((value)async{
      //     await Future.forEach(value.docs, (element) async {
      //   var product = await instance
      //       .collection(Collections.products.name)
      //       .doc(element.data()['productId'])
      //       .get();
      //   var fulproduct = {...element.data(), 'product': product.data()!};
      //   print("full odsodsodsods");
      //   print(fulproduct);
      //   result.add(fulproduct);
      // });
      // });

      final res = await instance.collection(mainCollection).get();
      if (res.docs.isEmpty) return [];

      // List<String> names = res.docs.map((e) => e.data()['productId'] as String).toList();

      // print("name is here man");
      // print(names);
      // var product = await instance.collection(Collections.products.name).where('productId', whereIn: names).get();

      //  print("product is herer man ss");
      //  print( product.docs);
      // await Future.forEach(res.docs, (element) async {
      //   var product = await instance
      //       .collection(Collections.products.name)
      //       .doc(element.data()['productId'])
      //       .get();
      //   var fulproduct = {...element.data(), 'product': product.data()!};
      //   result.add(fulproduct);
      // });
      return res.docs.map((e) => Purchase.fromJson(e.data())).toList();
    } catch (e) {
      return [];
    }
  }

  Future<List<Purchase>> searchPruchaseByName(String name) async {
    try {
      final res = await instance
          .collection(mainCollection)
          .where('productName', isGreaterThanOrEqualTo: name.toLowerCase())
          .where('productName', isLessThanOrEqualTo: '${name.toLowerCase()}z')
          .get();

      if (res.docs.isEmpty) return [];
      return res.docs.map((e) => Purchase.fromJson(e.data())).toList();
    } catch (e) {
      return [];
    }
  }
}


