import 'package:rich_co_inventory/models/purchase.dart';
import 'package:rich_co_inventory/providers/app_state_provider.dart';
import 'package:rich_co_inventory/repository/sections/purchase_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '.generated/purchase_provider.g.dart';

@Riverpod(keepAlive: true)
class PurchaseProvider extends _$PurchaseProvider {
  @override
  PurchaseState build() {
    return PurchaseState(me: 23);
  }

  Future<List<Purchase>> getPurchases(String date) async {
    return await PurchaseApis().getPurchaseByDate(date);
  }

  Future<String?> addPurchase(Purchase purchase, bool update) async {
    final loadingNotifier = ref.read(loadingStateProvider.notifier);
    loadingNotifier.activate();
    print(purchase);
    final id = update
        ? await PurchaseApis().update(purchase)
        : await PurchaseApis().add(purchase);
    loadingNotifier.finish();
    loadingNotifier.diactivate();
    return null;
  }
}

class PurchaseState {
  int? me;
  List<Purchase>? listpurchase;
  Purchase? purchas;
  PurchaseState({this.me, this.listpurchase, this.purchas});
}
