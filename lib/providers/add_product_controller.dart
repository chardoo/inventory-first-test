import 'package:rich_co_inventory/models/brand.dart';
import 'package:rich_co_inventory/models/product.dart';
import 'package:rich_co_inventory/models/supplier.dart';
import 'package:rich_co_inventory/repository/sections/product_apis.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repository/sections/brand_apis.dart';
import '../repository/sections/suppliers_api.dart';
import 'app_state_provider.dart';
part '.generated/add_product_controller.g.dart';

@Riverpod(keepAlive: true)
class AddProductProvider extends _$AddProductProvider {
  final BrandAPIs brandApis;
  final SuppliersApis supplierApis;
  final ProductApis productApis;
  AddProductProvider()
      : brandApis = BrandAPIs(),
        productApis = ProductApis(),
        supplierApis = SuppliersApis();
  @override
  AddProductState build() {
    return AddProductState();
  }

  Future addSupplier(Supplier supplier) async {
    final loadingState = ref.read(loadingStateProvider.notifier);
    loadingState.activate();
    await Future.delayed(Duration(seconds: 2));
    supplierApis.add(supplier);
    loadingState.finish();
    loadingState.diactivate();
  }

  Future<List> getSuppliers() async {
    brandApis.getAll();
    return [];
  }

  Future<List<Supplier>> searchSuppliers(String supplierName) async {
    print("I runnedsdsaf");
    return supplierApis.searchByName(supplierName);
  }

  addBrandToState(Brand brand) {
    state = state.copyWith(brand: brand);
  }

  addSupplierToState(Supplier supplier) {
    state = state.copyWith(supplier: supplier);
  }

  addBrand(Brand brand) async {
    final loadingState = ref.read(loadingStateProvider.notifier);
    loadingState.activate();
    await Future.delayed(Duration(seconds: 2));
    brandApis.add(brand);
    loadingState.finish();
    loadingState.diactivate();
  }

  addProduct(Product product) async {
    final loadingState = ref.read(loadingStateProvider.notifier);
    loadingState.activate();
    await Future.delayed(Duration(seconds: 2));
    productApis.add(product);
    loadingState.finish();
    loadingState.diactivate();
  }

  Future<List<Brand>> searchByName(String name) async {
    return brandApis.searchByName(name);
  }
}

class AddProductState {
  final Product? product;
  final Supplier? supplier;
  final Brand? brand;

  AddProductState copyWith(
      {Product? product, Supplier? supplier, Brand? brand}) {
    return AddProductState(
        brand: brand ?? this.brand,
        product: product ?? this.product,
        supplier: supplier ?? this.supplier);
  }

  AddProductState({this.product, this.supplier, this.brand});
}
