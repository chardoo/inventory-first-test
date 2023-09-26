import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rich_co_inventory/models/product.dart';
import 'package:rich_co_inventory/models/sales.dart';
import 'package:rich_co_inventory/providers/sales_cart_provider.dart';
import 'package:rich_co_inventory/screens.dart/dashboard.dart';
import 'package:rich_co_inventory/widgets/button.dart';
import 'package:rich_co_inventory/widgets/drop_down_field.dart';
import 'package:rich_co_inventory/widgets/loading_layout.dart';
import 'package:rich_co_inventory/widgets/text_fields.dart';

import '../../providers/product_provider.dart';
import '../../widgets/texts.dart';
part './product_detail_section.dart';
part './stock_detail_section.dart';
class AddSalesScreen extends StatelessWidget {
  AddSalesScreen({super.key});
  final List<Product> products = List.generate(
      5, (index) => const Product(productName: "productName", price: 2342));
  @override
  Widget build(BuildContext context) {
    return LoadingLayout(
      child: Scaffold(
          backgroundColor: Colors.grey.shade100,
          appBar: AppBar(
            title: const MyText(
              text: "Add Sales",
              weight: FontWeight.bold,
              size: 24,
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _ProductDetails(),
                    const SizedBox(height: 50),
                    StockDetails()
                  ]),
            ),
          )),
    );
  }
}


