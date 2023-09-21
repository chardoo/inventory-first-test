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
  add(Product product) async {
    try {
      final isProductExist =
          await checkPath(collection: mainCollection, id: product.productName);
      if (isProductExist) {
        //TODO: prevent user from adding
      } else {
        instance
            .collection(mainCollection)
            .doc(product.productName)
            .set(product.toJson());
      }
    } catch (e) {}
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
          collection: Collections.purchase.name,
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

 
  Future<Product?> getproductwithSale(String name) async {
    try {
      var salesResults ;
      final res = await instance.collection(mainCollection).doc(name).get();

      Map<String, dynamic> productData = res.data()!;
     
       salesResults = await instance.collection(salesCollection).where("field", isEqualTo: productData["productId"]).get().then((value){

      });

      
  
         

      if (res.exists) {
       Product product =   Product.fromJson(res.data()!);
    
      
     
     
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
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
}
