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
  update(Product product) async {
    try {
      await instance
          .collection(mainCollection)
          .doc(product.productName)
          .update(product.toJson());
    } catch (e) {
      //TODO: do something
    }
  }

  @override
  Future<Product?> getOne(String name) async {
    try {
      final res = await instance.collection(mainCollection).doc(name).get();

      Map<String, dynamic> productData = res.data()!;

      await instance.collection(salesCollection).get();
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


  Future<List<Sale>> getSalesforAProductForToday(String productId) async {
    try {
      print(productId);
       var today = DateTime.now().millisecondsSinceEpoch;
      final res = await instance
          .collection(Collections.sales.name)
          .where('productId', isEqualTo: productId)
       //    .where('saleDate', isLessThanOrEqualTo: today)
          .get();

        
      if (res.docs.isEmpty) return [];
      return res.docs.map((e) => Sale.fromJson(e.data())).toList();
    } catch (e) {
      return [];
    }
  }
}
