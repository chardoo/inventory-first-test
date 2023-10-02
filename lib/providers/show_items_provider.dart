import 'package:rich_co_inventory/models/brand.dart';
import 'package:rich_co_inventory/models/product.dart';
import 'package:rich_co_inventory/repository/sections/brand_apis.dart';
import 'package:rich_co_inventory/repository/sections/product_apis.dart';
import 'package:rich_co_inventory/repository/sections/purchase_api.dart';
import 'package:rich_co_inventory/repository/sections/sales_apis.dart';
import 'package:rich_co_inventory/repository/sections/stock.dart';
import 'package:rich_co_inventory/repository/sections/suppliers_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/supplier.dart';
import '../screens.dart/shared/view_all_items_states.dart';
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

  Future<List<Product>> getProducts() async {
    return await productApis.getAll();
  }

  seachProducts(String string) async {
    state = LoadingState();
    final data = await productApis.searchByName(string);
    if (data.isEmpty) {
      state = EmptyState();
      return;
    }
  }

  Future<List<Brand>> getBrand() async {
    return await brandAPIs.getAll();
  }

  Future<({String? error, bool isError})> deleteBrand(Brand brand) async {
    return await brandAPIs.delete(brand);
  }

  Future<({String? error, bool isError})> deleteSupplier(Supplier supplier) async {
    return await suppliersApis.delete(supplier);
  }

  Future<List<Supplier>> getSuppliers() async {
    return await suppliersApis.getAll();
  }

  // search(String searchValue) {
  //   state = LoadingState();
  //   //
  // }
}
