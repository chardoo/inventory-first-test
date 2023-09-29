import 'package:rich_co_inventory/models/purchase.dart';
import 'package:rich_co_inventory/models/stock.dart';
import 'package:rich_co_inventory/providers/app_state_provider.dart';
import 'package:rich_co_inventory/repository/sections/stock.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '.generated/inventory_provider.g.dart';

@Riverpod(keepAlive: true)
class InventoryProvider extends _$InventoryProvider {
  @override
  PurchaseState build() {
    return PurchaseState(me: 23);
  }

  Future<List<Stock>> getInventory(String name) async {
    return await StockApis().getStockByProductName(name);
  }


  Future<String?> addInventory(Stock stock, bool update) async {
    // final id = PurchaseApis().add(purchase);
    final loadingState = ref.read(loadingStateProvider.notifier);
    loadingState.activate();
    var currentStock = await StockApis().getStockByProductId(stock.productId);
    StockApis().update(Stock(
        stockId: currentStock[0]!.stockId,
        productId: currentStock[0]!.productId,
        productPrice: currentStock[0]!.productPrice,
        productName: stock.productName,
        currentQuantity: update
            ? stock.currentQuantity
            : currentStock[0]!.currentQuantity + stock.currentQuantity,
        minimumRequiredQuantity: currentStock[0]!.minimumRequiredQuantity));
    loadingState.diactivate();

    return '';
  }
}

class PurchaseState {
  int? me;
  List<Purchase>? listpurchase;
  Purchase? purchas;
  PurchaseState({this.me, this.listpurchase, this.purchas});
}
