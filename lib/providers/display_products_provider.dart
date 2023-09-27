import 'package:flutter/material.dart';
import 'package:rich_co_inventory/models/product.dart';
import 'package:rich_co_inventory/models/sales.dart';
import 'package:rich_co_inventory/models/stock.dart';
import 'package:rich_co_inventory/repository/sections/product_apis.dart';
import 'package:rich_co_inventory/repository/sections/sales_apis.dart';
import 'package:rich_co_inventory/repository/sections/stock.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../screens.dart/inventory/all_inventory.dart';
import '../screens.dart/product_feature/products_screen.dart';
import '../screens.dart/sales_feature/sales_page.dart';
import '../widgets/shimmer.dart';
import '../widgets/texts.dart';
part '.generated/display_products_provider.g.dart';

@riverpod
class DisplayProductsProvider extends _$DisplayProductsProvider {
  final ProductApis productApis;
  final StockApis stockApis;
  final SalesApi salesApi;
  DisplayProductsProvider()
      : productApis = ProductApis(),
        salesApi = SalesApi(),
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

  getStocks() async {
    state = LoadingState();
    final data = await stockApis.getAll();
    state = StockSuccessState(data);
  }

  getSales() async {
    state = LoadingState();
    final data = await salesApi.getAll();
    state = SalesSuccessState(data);
  }

  search(String searchValue) {
    state = LoadingState();
    // 
  }
}

abstract class ProductDisplayState {
  Widget display();
}

class LoadingState extends ProductDisplayState {
  @override
  display() {
    return Expanded(
      child: ListView.separated(
          separatorBuilder: (_, i) => const SizedBox(height: 12),
          itemCount: 10,
          itemBuilder: (_, i) {
            return const ListTile(
              title: ShimmerLayout(
                height: 20,
                width: 50,
              ),
              subtitle: ShimmerLayout(
                height: 20,
                width: 80,
              ),
              trailing: ShimmerLayout(
                height: 20,
                width: 20,
                shape: BoxShape.circle,
              ),
            );
          }),
    );
  }
}

class ErrorState extends ProductDisplayState {
  final String error;

  ErrorState(this.error);
  @override
  display() {
    return Center(
      child: MyText(
        text: error,
        size: 24,
        weight: FontWeight.bold,
      ),
    );
  }
}

class EmptyState extends ProductDisplayState {
  @override
  display() {
    return const Center(
      child: MyText(
        text: "No Items in store",
        size: 24,
        weight: FontWeight.bold,
      ),
    );
  }
}

abstract class SuccessState<T> extends ProductDisplayState {
  final T data;

  SuccessState(this.data);
}

class ProductSuccessState extends SuccessState<List<Product>> {
  ProductSuccessState(super.data);

  @override
  display() {
    return Expanded(
      child: ListView.separated(
          separatorBuilder: (_, i) => const SizedBox(height: 12),
          itemCount: data.length,
          itemBuilder: (_, i) {
            final product = data[i];
            return ProductCard(
                productId: product.productId!,
                name: product.productName,
                description: product.productDescription ?? "");
          }),
    );
  }
}

class StockSuccessState extends SuccessState<List<Stock>> {
  StockSuccessState(super.data);

  @override
  display() {
    return Expanded(
      child: ListView.separated(
          separatorBuilder: (_, i) => const SizedBox(height: 12),
          itemCount: data.length,
          itemBuilder: (_, i) {
            //  return Text("richOCDE");
            final inventory = data[i];
            return PurchaseCard(
              //  date: inventory.purchaseDate,
              productName: inventory.productName!,
              quantity: inventory.currentQuantity,
            );
          }),
    );
  }
}

class SalesSuccessState extends SuccessState<List<Sale>> {
  SalesSuccessState(super.data);

  @override
  display() {
    print(data);
    return Expanded(
      child: ListView.separated(
        itemBuilder: (_, i) {
          final sale = data[i];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SalesCard(
              name: sale.productName,
            ),
          );
        },
        itemCount: data.length,
        separatorBuilder: (BuildContext context, int index) {
          return const Divider();
        },
      ),
    );
  }
}
