import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rich_co_inventory/models/product.dart';
import 'package:rich_co_inventory/models/sales.dart';
import 'package:rich_co_inventory/repository/firestore_apis.dart';

class ProductApis extends FireStoreAPIs<Product> {
  @override
  String get mainCollection => Collections.products.name;
  String get salesCollection => Collections.sales.name;

  @override
  String get dependantCollection => "";

  @override
  Future<String?> add(Product item) async {
    final productToAdd = Product.generateId(item.toJson());
    try {
      final isProductExist =
          await checkPath(collection: mainCollection, id: item.productName);
      if (isProductExist) {
        //TODO: prevent user from adding
      } else {
        instance
            .collection(mainCollection)
            .doc(productToAdd.productId)
            .set(productToAdd.toJson());

        return productToAdd.productId;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  delete(Product product) async {
    try {
      final hasConnectionToStock = await check(
          collection: dependantCollection,
          field: "productId",
          arg: product.productName);
      final hasConnectionToSales = await check(
          collection: Collections.sales.name,
          field: "productId",
          arg: product.productName);
      final hasConnectionToPurchase = await check(
          collection: Collections.purchases.name,
          field: "productId",
          arg: product.productName);
      if (hasConnectionToPurchase ||
          hasConnectionToSales ||
          hasConnectionToStock) {
        //TODO: cant delete product
      } else {
        final docToDelete =
            instance.collection(dependantCollection).doc(product.productName);
        docToDelete.delete();
      }
    } catch (e) {
      print("error is $e");
    }
  }

  @override
  Future<String?> update(Product product) async {
    print("product is $product");

    try {
      await instance
          .collection(mainCollection)
          .doc(product.productId)
          .update(product.toJson());
      print("success");
      return product.productId;
    } on FirebaseException catch (e) {
      print("error is ${e.message}");
      return null;
      //TODO: do something
    }
  }

  Future<List<Product>?> productsNearingExpiring() async {
    final threeMonthsFromNow = DateTime.now().add(Duration(days: 90));
    try {
      final res = await instance
          .collection(mainCollection)
          .where("expiryDate",
              isLessThanOrEqualTo: threeMonthsFromNow.millisecondsSinceEpoch)
          .get();
      if (res.docs.isEmpty) return null;
      return res.docs.map((e) => Product.fromJson(e.data())).toList();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Product?> getOne(String name) async {
    try {
      final res = await instance.collection(mainCollection).doc(name).get();

      if (res.exists) {
        return Product.fromJson(res.data()!);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Product?> getProductStatistic(String productId) async {
    try {
      // final salesResults = await instance.collection(Collections.sales.name).where("productId", isEqualTo: productId).get();
      // final stocksResults =  await instance.collection(Collections.stock.name).where("productId", isEqualTo: productId).get();

      // Map<String, dynamic> productData = res.data()!;

      // await instance.collection(salesCollection).get();
      // if (res.exists) {
      //   return Product.fromJson(res.data()!);
      // } else {
      //   return null;
      // }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<Product?> getproductwithSale(String name) async {
    try {
      var salesResults;
      final res = await instance.collection(mainCollection).doc(name).get();

      Map<String, dynamic> productData = res.data()!;

      salesResults = await instance
          .collection(salesCollection)
          .where("field", isEqualTo: productData["productId"])
          .get()
          .then((value) {});

      if (res.exists) {
        Product product = Product.fromJson(res.data()!);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  @override
  Future<List<Product>> getAll() async {
    try {
      final res = await instance.collection(mainCollection).get();
      if (res.docs.isEmpty) return [];
      return res.docs.map((e) => Product.fromJson(e.data())).toList();
    } catch (e) {
      return [];
    }
  }

  Future<List<Product>> searchByName(String name) async {
    try {
      final res = await instance
          .collection(mainCollection)
          .where('productName', isGreaterThanOrEqualTo: name.toLowerCase())
          .where('productName', isLessThanOrEqualTo: '${name.toLowerCase()}z')
          .get();

      if (res.docs.isEmpty) return [];
      return res.docs.map((e) => Product.fromJson(e.data())).toList();
    } catch (e) {
      return [];
    }
  }

  Future<List<Sale>> getSalesforAProductForToday(
      String productId, DateTime? start, DateTime? end) async {
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
      days = days.toSet().toList();
      var res = await instance
          .collection(Collections.sales.name)
          .where('productId', isEqualTo: productId)
          .where("saleDate", whereIn: days)
          .get();

      if (res.docs.isEmpty) return [];
      return res.docs.map((e) => Sale.fromJson(e.data())).toList();
    } catch (e) {
      return [];
    }
  }
}
