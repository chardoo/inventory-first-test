import 'package:rich_co_inventory/models/brand.dart';
import 'package:rich_co_inventory/models/product.dart';
import 'package:rich_co_inventory/models/purchase.dart';
import 'package:rich_co_inventory/models/stock.dart';
import 'package:rich_co_inventory/models/supplier.dart';
import 'package:rich_co_inventory/repository/sections/product_apis.dart';
import 'package:rich_co_inventory/repository/sections/purchase_api.dart';
import 'package:rich_co_inventory/repository/sections/stock.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repository/sections/brand_apis.dart';
import '../repository/sections/suppliers_api.dart';
import 'app_state_provider.dart';


@Riverpod(keepAlive: true)
class SalesProvider extends _$SalesProvider {

 @override
  SalesState build(){

    return  SalesState(me: 23);
}

//    getPurchaseS()async{

//     List<Purchase> results = await  PurchaseApis().getAll();
//    state = SalesState( me: 45, purchas: state.purchas, listOfProduct: results);
//    }
 
//  changeinter(){
//   state = SalesState(me: 23, purchas: state.purchas, listOfProduct: state.listpurchase);
//  }




  Future<List<Purchase>>getPurchases(String date)async{

   var resutl =   await  PurchaseApis().getPurchaseByDate(date);
   print("her this here man");
   print(resutl);
    return    resutl;
    
  
 
   }


  Future<String?> addPurchase(Purchase purchase) async {
  
    final id = PurchaseApis().add(purchase);

    var currentStock = await StockApis().getStockByProductId(purchase.productId);
    print("current stock");
     print(currentStock);

     StockApis().update(Stock(stockId: currentStock[0]!.stockId,  productId: currentStock[0]!.productId!, currentQuantity: currentStock[0]!.currentQuantity+purchase.quantityPurchased, minimumRequiredQuantity: currentStock[0]!.minimumRequiredQuantity));
   
    return id;
  }   


}

class SalesState{
  int ? me;
 List<Product> ?listOfProduct;
 Purchase ?purchas;
 SalesState({ this.me, this.listOfProduct, this.purchas });
}


