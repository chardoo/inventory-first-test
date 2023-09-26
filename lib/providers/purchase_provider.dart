import 'package:rich_co_inventory/models/purchase.dart';
import 'package:rich_co_inventory/models/stock.dart';
import 'package:rich_co_inventory/repository/sections/purchase_api.dart';
import 'package:rich_co_inventory/repository/sections/stock.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '.generated/purchase_provider.g.dart';

@Riverpod(keepAlive: true)
class PurchaseProvider extends _$PurchaseProvider {
  @override
  PurchaseState build() {
    return PurchaseState(me: 23);
  }

//    getPurchaseS()async{

//     List<Purchase> results = await  PurchaseApis().getAll();
//    state = PurchaseState( me: 45, purchas: state.purchas, listpurchase: results);
//    }

//  changeinter(){
//   state = PurchaseState(me: 23, purchas: state.purchas, listpurchase: state.listpurchase);
//  }

  Future<List<Purchase>> getPurchases(String date) async {
    return await PurchaseApis().getPurchaseByDate(date);
  }

  Future<String?> addPurchase(Purchase purchase) async {
    final id = PurchaseApis().add(purchase);
  }
}

class PurchaseState {
  int? me;
  List<Purchase>? listpurchase;
  Purchase? purchas;
  PurchaseState({this.me, this.listpurchase, this.purchas});
}
