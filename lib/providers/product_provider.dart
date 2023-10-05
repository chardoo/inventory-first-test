import 'package:rich_co_inventory/models/brand.dart';
import 'package:rich_co_inventory/models/product.dart';
import 'package:rich_co_inventory/models/sales.dart';
import 'package:rich_co_inventory/models/stock.dart';
import 'package:rich_co_inventory/models/supplier.dart';
import 'package:rich_co_inventory/providers/sales_provider.dart';
import 'package:rich_co_inventory/repository/sections/product_apis.dart';
import 'package:rich_co_inventory/repository/sections/sales_apis.dart';
import 'package:rich_co_inventory/repository/sections/stock.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repository/sections/brand_apis.dart';
import '../repository/sections/suppliers_api.dart';
import 'app_state_provider.dart';
part '.generated/product_provider.g.dart';

@Riverpod(keepAlive: true)
class AddProductProvider extends _$AddProductProvider {
  final BrandAPIs brandApis;
  final SuppliersApis supplierApis;
  final ProductApis productApis;
  final StockApis stockApis;
  final SalesApi salesApi;
  AddProductProvider()
      : brandApis = BrandAPIs(),
        salesApi = SalesApi(),
        productApis = ProductApis(),
        stockApis = StockApis(),
        supplierApis = SuppliersApis();
  @override
  AddProductState build() {
    return AddProductState(totalSalesforProduct: 0, sales: []);
  }

  Future<({String? error, bool isError})> addSupplier(
      Supplier supplier, bool update) async {
    final loadingState = ref.read(loadingStateProvider.notifier);
    loadingState.activate();
    final res = update
        ? await supplierApis.update(supplier)
        : await supplierApis.add(supplier);
    loadingState.finish();

    loadingState.diactivate();
    return res;
  }

  Future<String?> addStock(Stock stock, bool update) async {
    final loadingState = ref.read(loadingStateProvider.notifier);
    loadingState.activate();
    final res =
        update ? await stockApis.update(stock) : await stockApis.add(stock);
    loadingState.finish();
    loadingState.diactivate();
    return res;
  }

  Future<String?> addSales(Sale sales) async {
    final loadingState = ref.read(loadingStateProvider.notifier);
    loadingState.activate();
    final res = await Future.delayed(const Duration(seconds: 2));
    salesApi.add(sales);

    loadingState.finish();
    loadingState.diactivate();
    return res;
  }

  Future<List> getSuppliers() async {
    brandApis.getAll();
    return [];
  }

  Future<List<Product>?>  getProductsNearingExpiry() async {
  return  productApis.productsNearingExpiring();
  }

  Future<List<Supplier>> searchSuppliers(String supplierName) async {
    return supplierApis.searchByName(supplierName);
  }

  addBrandToState(Brand brand) {
    state = state.copyWith(brand: brand);
  }

  addSupplierToState(Supplier supplier) {
    state = state.copyWith(supplier: supplier);
  }

  addBrand(Brand brand, bool update) async {
    final loadingState = ref.read(loadingStateProvider.notifier);
    loadingState.activate();
    await Future.delayed(const Duration(seconds: 2));
    update ? await brandApis.update(brand) : await brandApis.add(brand);
    loadingState.finish();
    loadingState.diactivate();
  }

  Future<String?> addProduct(Product product, bool update) async {
    final loadingState = ref.read(loadingStateProvider.notifier);
    loadingState.activate();

    final id = update
        ? await productApis.update(product)
        : await productApis.add(product);
    loadingState.finish();
    loadingState.diactivate();
    return id;
  }

  Future<List<Product>> searchProductByName(String name) async {
    return productApis.searchByName(name);
  }

  Future<Product?> getProductById(String id) async {
    return productApis.getOne(id);
  }

  Future<List<Brand>> searchByName(String name) async {
    return brandApis.searchByName(name);
  }

  Future<List<Sale>> getsalesForAProduct(
      String productId, DateTime? startTime, DateTime? endTime) async {
    var results = await productApis.getSalesforAProductForToday(
        productId, startTime, endTime);

    var total = 0.0;
    for (var element in results) {
      total = total + element.productPrice * element.quantitySold!;
    }

    state = AddProductState(totalSalesforProduct: total, sales: results);
    return results;
  }
}

class AddProductState {
  final Product? product;
  final Supplier? supplier;
  final Brand? brand;
  final double totalSalesforProduct;
  List<Sale> sales = [];

  AddProductState copyWith(
      {Product? product,
      Supplier? supplier,
      Brand? brand,
      double? totalSalesforProduct,
      List<Sale>? sales}) {
    return AddProductState(
        sales: sales ?? this.sales,
        brand: brand ?? this.brand,
        product: product ?? this.product,
        supplier: supplier ?? this.supplier,
        totalSalesforProduct:
            totalSalesforProduct ?? this.totalSalesforProduct);
  }

  AddProductState(
      {this.product,
      this.supplier,
      this.brand,
      required this.totalSalesforProduct,
      required this.sales});
}
