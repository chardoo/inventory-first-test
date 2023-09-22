import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rich_co_inventory/helpers/navigator.dart';
import 'package:rich_co_inventory/providers/add_product_controller.dart';
import 'package:rich_co_inventory/screens.dart/add_to_product/add_product_screen.dart';
import 'package:rich_co_inventory/widgets/button.dart';
import 'package:rich_co_inventory/widgets/shimmer.dart';
import 'package:rich_co_inventory/widgets/text_fields.dart';
import 'package:rich_co_inventory/widgets/texts.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final TextEditingController searchCtrl = TextEditingController(text: "");

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
          title:
              MyText(text: "All Products", weight: FontWeight.bold, size: 24)),
      body: Container(
        padding: const EdgeInsets.all(24.0),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), topRight: Radius.circular(8)),
            color: Colors.white),
        margin: EdgeInsets.only(top: 24),
        child: Column(children: [
          Row(
            children: [
              Expanded(
                  child: MyTextField(
                controller: searchCtrl,
                label: "Type item name",
                onChanged: (val) {
                  searchCtrl.text = val;
                  setState(() {});
                },
              )),
              const SizedBox(width: 12),
              MyFilledIconButton(
                icon: Icon(
                  Icons.add,
                  size: 12,
                ),
                label: MyText(
                  text: "Add  ",
                  size: 12,
                  color: Colors.blue,
                ),
                ontap: () {
                  MyNavigator.goto(context, AddProductScreen());
                },
              )
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Consumer(builder: (context, ref, _) {
              return FutureBuilder(
                  future: ref
                      .read(addProductProvider.notifier)
                      .searchProductByName(searchCtrl.text),
                  builder: (_, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return ListView.separated(
                          separatorBuilder: (_, i) => SizedBox(height: 12),
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
                          });
                    }

                    if (snapshot.hasData) {
                      if (snapshot.requireData.isEmpty) {
                        return const Center(
                          child: MyText(
                            text: "No products in store",
                            size: 24,
                            weight: FontWeight.bold,
                          ),
                        );
                      }
                      return ListView.separated(
                          separatorBuilder: (_, i) => SizedBox(height: 12),
                          itemCount: snapshot.requireData.length,
                          itemBuilder: (_, i) {
                            final product = snapshot.requireData[i];
                            return ProductCard(
                                name: product.productName,
                                description: product.productDescription ?? "");
                          });
                    }
                    return Center(
                      child: MyText(
                        text: snapshot.error?.toString() ?? "",
                        size: 24,
                        weight: FontWeight.bold,
                      ),
                    );
                  });
            }),
          )
        ]),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.name,
    required this.description,
  });

  final String name;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey.shade100),
      child: ListTile(
        title: MyText(
          text: name,
          weight: FontWeight.bold,
          size: 16,
          maxLines: 1,
        ),
        subtitle: MyText(
          text: description,
          size: 14,
          maxLines: 1,
          color: Colors.blueGrey,
        ),
        trailing: Icon(
          Icons.edit,
          color: Colors.blueGrey,
        ),
      ),
    );
  }
}
