import 'package:flutter/material.dart';
import 'package:rich_co_inventory/models/product.dart';
import 'package:rich_co_inventory/models/sales.dart';
import 'package:rich_co_inventory/repository/sections/product_apis.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../screens.dart/product_display/products_screen.dart';
import '../widgets/shimmer.dart';
import '../widgets/texts.dart';
part '.generated/display_products_provider.g.dart';

@riverpod
class DisplayProductsProvider extends _$DisplayProductsProvider {
  final ProductApis productApis;
  DisplayProductsProvider() : productApis = ProductApis();
  @override
  ProductDisplayState build() {
    return EmptyState();
  }

  getData() async {
    state = LoadingState();
    final data = await productApis.getAll();
    state = SuccessState(data);
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
        text: "No products in store",
        size: 24,
        weight: FontWeight.bold,
      ),
    );
  }
}

class SuccessState extends ProductDisplayState {
  final List<Product> sales;

  SuccessState(this.sales);
  @override
  display() {
    return Expanded(
      child: ListView.separated(
          separatorBuilder: (_, i) => const SizedBox(height: 12),
          itemCount: sales.length,
          itemBuilder: (_, i) {
            final product = sales[i];
            return ProductCard(
                productId: product.productId!,
                name: product.productName,
                description: product.productDescription ?? "");
          }),
    );
  }
}
