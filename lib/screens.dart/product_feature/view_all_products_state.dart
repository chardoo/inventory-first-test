

import 'package:flutter/material.dart';
import 'package:rich_co_inventory/screens.dart/product_feature/products_screen.dart';

import '../../models/product.dart';
import '../shared/view_all_items_states.dart';

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