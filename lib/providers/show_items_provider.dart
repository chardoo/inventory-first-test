import 'package:flutter/material.dart';
import 'package:rich_co_inventory/models/brand.dart';
import 'package:rich_co_inventory/models/product.dart';
import 'package:rich_co_inventory/models/purchase.dart';
import 'package:rich_co_inventory/models/sales.dart';
import 'package:rich_co_inventory/models/stock.dart';
import 'package:rich_co_inventory/models/supplier.dart';
import 'package:rich_co_inventory/repository/sections/brand_apis.dart';
import 'package:rich_co_inventory/repository/sections/product_apis.dart';
import 'package:rich_co_inventory/repository/sections/purchase_api.dart';
import 'package:rich_co_inventory/repository/sections/sales_apis.dart';
import 'package:rich_co_inventory/repository/sections/stock.dart';
import 'package:rich_co_inventory/repository/sections/suppliers_api.dart';
import 'package:rich_co_inventory/screens.dart/shared/widgets/list_tile_card.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../screens.dart/brand_feature/view_brand_state.dart';
import '../screens.dart/inventory/all_inventory.dart';
import '../screens.dart/product_feature/products_screen.dart';
import '../screens.dart/product_feature/view_all_products_state.dart';
import '../screens.dart/purchase_feature/all_purchase_page.dart';
import '../screens.dart/purchase_feature/view_all_purchase_state.dart';
import '../screens.dart/sales_feature/sales_page.dart';
import '../screens.dart/sales_feature/view_all_sales_state.dart';
import '../screens.dart/shared/view_all_items_states.dart';
import '../screens.dart/shared/widgets/shimmer.dart';
import '../screens.dart/shared/widgets/texts.dart';
import '../screens.dart/stocks_feature/view_all_stock_state.dart';
import '../screens.dart/supplier_feature.dart/view_all_suppliers_state.dart';
part '.generated/show_items_provider.g.dart';

@riverpod
class DisplayProductsProvider extends _$DisplayProductsProvider {
  final ProductApis productApis;
  final StockApis stockApis;
  final PurchaseApis purchaseApis;
  final BrandAPIs brandAPIs;
  final SalesApi salesApi;
  final SuppliersApis suppliersApis;
  DisplayProductsProvider()
      : productApis = ProductApis(),
        salesApi = SalesApi(),
        suppliersApis = SuppliersApis(),
        brandAPIs = BrandAPIs(),
        purchaseApis = PurchaseApis(),
        stockApis = StockApis();
  @override
  ProductDisplayState build() {
    return EmptyState();
  }

  getProducts() async {
    state = LoadingState();
    final data = await productApis.getAll();
    state = ProductSuccessState(data);
  }

  seachProducts(String string) async {
    state = LoadingState();
    final data = await productApis.searchByName(string);
    if (data.isEmpty) {
      state = EmptyState();
      return;
    }
    state = ProductSuccessState(data);
  }

  searchStock(String string) async {
    state = LoadingState();
    final data = await stockApis.getStockByProductName(string);
    if (data.isEmpty) {
      state = EmptyState();
      return;
    }
    state = StockSuccessState(data);
  }

  searchPurchases(String string) async {
    state = LoadingState();
    final data = await purchaseApis.searchPruchaseByName(string);
    if (data.isEmpty) {
      state = EmptyState();
      return;
    }
    state = PurchaseSuccessState(data);
  }

  getStocks() async {
    state = LoadingState();
    final data = await stockApis.getAll();
    state = StockSuccessState(data);
  }

  getBrand() async {
    state = LoadingState();
    final data = await brandAPIs.getAll();
    state = BrandSuccessState(data);
  }

  getPurchase() async {
    state = LoadingState();
    final data = await purchaseApis.getAll();
    state = PurchaseSuccessState(data);
  }

  getSales() async {
    state = LoadingState();
    final data = await salesApi.getAll();
    state = SalesSuccessState(data);
  }

  getSuppliers() async {
    state = LoadingState();
    final data = await suppliersApis.getAll();
    state = SupplierSuccessState(data);
  }

  // search(String searchValue) {
  //   state = LoadingState();
  //   //
  // }
}
