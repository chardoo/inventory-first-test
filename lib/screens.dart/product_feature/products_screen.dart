import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rich_co_inventory/helpers/navigator.dart';
import 'package:rich_co_inventory/models/product.dart';
import 'package:rich_co_inventory/providers/show_items_provider.dart';
import 'package:rich_co_inventory/providers/product_provider.dart';
import 'package:rich_co_inventory/screens.dart/product_feature/product_details.dart';
import 'package:rich_co_inventory/widgets/button.dart';
import 'package:rich_co_inventory/widgets/text_fields.dart';
import 'package:rich_co_inventory/widgets/texts.dart';

import '../../widgets/shimmer_loader.dart';
import 'add_product_screen.dart';

class ProductsScreen extends ConsumerStatefulWidget {
  const ProductsScreen({super.key});

  @override
  ConsumerState<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends ConsumerState<ProductsScreen> {
  final TextEditingController searchCtrl = TextEditingController(text: "");

  @override
  void initState() {
    Future.microtask(
        () => ref.read(displayProductsProvider.notifier).getProducts());
    super.initState();
  }

  Timer? timer;
  refresh() {
    setState(() {});
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
          title: const MyText(
              text: "All Products", weight: FontWeight.bold, size: 24)),
      body: Container(
        padding: const EdgeInsets.all(24.0),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), topRight: Radius.circular(8)),
            color: Colors.white),
        margin: const EdgeInsets.only(top: 24),
        child: Column(children: [
          Row(
            children: [
              Expanded(
                  child: MyTextField(
                controller: searchCtrl,
                label: "Type product name",
                onChanged: (val) {
                  timer?.cancel();
                  timer = null;
                  timer = Timer(const Duration(seconds: 2), () {
                    setState(() {});
                  });
                },
              )),
              const SizedBox(width: 12),
              MyFilledIconButton(
                icon: const Icon(
                  Icons.add,
                  size: 12,
                ),
                label: const MyText(
                  text: "Add  ",
                  size: 12,
                  color: Colors.blue,
                ),
                ontap: () {
                  MyNavigator.goto(context, const AddProductScreen());
                },
              )
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async => refresh(),
              child: FutureBuilder(
                  future: ref
                      .read(addProductProvider.notifier)
                      .searchProductByName(searchCtrl.text),
                  builder: (_, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const ShimmerLoader();
                    }

                    if (snapshot.hasData) {
                      if (snapshot.requireData.isEmpty) {
                        return const Center(
                          child: MyText(
                            text: "No Products yet",
                            size: 24,
                            weight: FontWeight.bold,
                          ),
                        );
                      }
                      return ListView.separated(
                          separatorBuilder: (_, i) =>
                              const SizedBox(height: 12),
                          itemCount: snapshot.requireData.length,
                          itemBuilder: (_, i) {
                            final product = snapshot.requireData[i];
                            return ProductCard(
                              product: product,
                            );
                          });
                    }
                    return Center(
                      child: MyText(
                        text: snapshot.error?.toString() ?? "",
                        size: 24,
                        weight: FontWeight.bold,
                      ),
                    );
                  }),
            ),
          )
        ]),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          MyNavigator.goto(
              context,
              ProductDetailScreen(
                  productId: product.productId!,
                  productName: product.productName));
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey.shade100),
          child: ListTile(
            title: MyText(
              text: product.productName,
              weight: FontWeight.bold,
              size: 16,
              maxLines: 1,
            ),
            subtitle: MyText(
              text: product.productDescription ?? "",
              size: 14,
              maxLines: 1,
              color: Colors.blueGrey,
            ),
            trailing: GestureDetector(
              onTap: () {
                MyNavigator.goto(
                    context,
                    AddProductScreen(
                      product: product,
                    ));
              },
              child: const Icon(
                Icons.edit,
                color: Colors.blueGrey,
              ),
            ),
          ),
        ));
  }
}
