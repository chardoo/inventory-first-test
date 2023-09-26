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
part '.generated/purchase_provider.g.dart';

@Riverpod(keepAlive: true)
class PurchaseProvider extends _$PurchaseProvider {

 @override
  PurchaseState build(){

    return  PurchaseState(me: 23);
}

//    getPurchaseS()async{

//     List<Purchase> results = await  PurchaseApis().getAll();
//    state = PurchaseState( me: 45, purchas: state.purchas, listpurchase: results);
//    }
 
//  changeinter(){
//   state = PurchaseState(me: 23, purchas: state.purchas, listpurchase: state.listpurchase);
//  }




  Future<List<Purchase>>getPurchases(String date)async{
  return await  PurchaseApis().getPurchaseByDate(date);
   }


  Future<String?> addPurchase(Purchase purchase) async {
    final id = PurchaseApis().add(purchase);
    var currentStock = await StockApis().getStockByProductId(purchase.productId);
     StockApis().update(Stock( productPrice: currentStock[0]!.productPrice, productName: currentStock[0]!.productName,  stockId: currentStock[0]!.stockId,  productId: currentStock[0]!.productId!, currentQuantity: currentStock[0]!.currentQuantity+purchase.quantityPurchased, minimumRequiredQuantity: currentStock[0]!.minimumRequiredQuantity));
    return id;
  }   


}

class PurchaseState{
  int ? me;
 List<Purchase> ?listpurchase;
 Purchase ?purchas;
 PurchaseState({ this.me, this.listpurchase, this.purchas });
}


