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

  Future<List<Purchase>> getPurchases(String name) async {
    return await PurchaseApis().searchPruchaseByName(name);
  }

  setWeeklyAndMonthlyPurchase() async {
    final weekly = await PurchaseApis().getTotalPurchasesForAWeek();
    final monthly = await PurchaseApis().getTotalPurchasesForMonth();
    state = PurchaseState(
        listpurchase: state.listpurchase,
        me: state.me,
        monthlyTotal: monthly,
        purchas: state.purchas,
        weeklyTotal: weekly);
  }

  Future<({String? data, String? error, bool isError})> addPurchase(
      Purchase purchase, bool update) async {
    final loadingNotifier = ref.read(loadingStateProvider.notifier);
    loadingNotifier.activate();
    final res = update
        ? await PurchaseApis().update(purchase)
        : await PurchaseApis().add(purchase);
    setWeeklyAndMonthlyPurchase();

    loadingNotifier.finish();
    loadingNotifier.diactivate();
    return res;
  }
}

class PurchaseState {
  int? me;
  final double monthlyTotal;
  final double weeklyTotal;
  List<Purchase>? listpurchase;
  Purchase? purchas;
  PurchaseState({
    this.me,
    this.listpurchase,
    this.purchas,
    this.monthlyTotal = 0,
    this.weeklyTotal = 0,
  });
}
