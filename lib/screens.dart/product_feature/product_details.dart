import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rich_co_inventory/providers/show_items_provider.dart';
import 'package:rich_co_inventory/providers/inventory_provider.dart';
import 'package:rich_co_inventory/providers/product_provider.dart';
import 'package:rich_co_inventory/screens.dart/dashboard_feauture/dashboard.dart';

import 'package:rich_co_inventory/screens.dart/inventory/all_inventory.dart';
import 'package:rich_co_inventory/widgets/shimmer.dart';
import 'package:rich_co_inventory/widgets/texts.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  final String productId;
  final String productName;
  const ProductDetailScreen(
      {required this.productId, required this.productName, super.key});

  @override
  ConsumerState<ProductDetailScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends ConsumerState<ProductDetailScreen> {
  final TextEditingController searchCtrl = TextEditingController(text: "");

  @override
  void initState() {
    // Future.microtask(
    //     () => ref.read(displayProductsProvider.notifier).getData());
    super.initState();
  }

  DateTime? startTime;
  DateTime? endTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
          title: MyText(
              text: "${widget.productName} Summary",
              weight: FontWeight.bold,
              size: 24)),
      body: Container(
        padding: const EdgeInsets.all(24.0),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), topRight: Radius.circular(8)),
            color: Colors.white),
        margin: const EdgeInsets.only(top: 24),
        child: Column(children: [
          Consumer(builder: (context, ref, _) {
            return MyText(
                text: ref
                    .watch(addProductProvider)
                    .totalSalesforProduct
                    .toString(),
                weight: FontWeight.bold,
                size: 24);
          }),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyIconButton(
                label: "start",
                forgroundColor: Colors.grey,
                borderColor: Colors.grey,
                bgColor: Colors.white,
                icon: const RotatedBox(
                    quarterTurns: 3, child: Icon(Icons.chevron_left)),
                ontap: () async {
                  startTime = null;
                  final selectedDate = await showDatePicker(
                      // currentDate: currentDate,
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate:
                          DateTime.now().subtract(const Duration(days: 1000)),
                      lastDate: DateTime.now().add(const Duration(days: 1000)));
                  startTime = selectedDate;
                },
              ),
              MyIconButton(
                  label: "endDate",
                  forgroundColor: Colors.grey,
                  borderColor: Colors.grey,
                  bgColor: Colors.white,
                  ontap: () async {
                    final selectedDate = await showDatePicker(
                        // currentDate: currentDate,
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate:
                            DateTime.now().subtract(const Duration(days: 1000)),
                        lastDate:
                            DateTime.now().add(const Duration(days: 1000)));
                    endTime = selectedDate;

                    if (startTime != null && endTime != null) {
                      setState(() {});
                    }
                  },
                  icon: const RotatedBox(
                      quarterTurns: 3, child: Icon(Icons.chevron_left))),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Consumer(builder: (context, ref, _) {
              return FutureBuilder(
                  future: ref
                      .read(addProductProvider.notifier)
                      .getsalesForAProduct(
                          widget.productId, startTime, endTime),
                  builder: (_, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return ListView.separated(
                          separatorBuilder: (_, i) =>
                              const SizedBox(height: 12),
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
                            text: "No Sales yet",
                            size: 24,
                            weight: FontWeight.bold,
                          ),
                        );
                      }
                      return ListView.separated(
                          separatorBuilder: (_, i) =>
                              const SizedBox(height: 12),
                          itemCount: ref.watch(addProductProvider).sales.length,
                          itemBuilder: (_, i) {
                            //  return Text("richOCDE");
                            final sales = ref.watch(addProductProvider).sales;
                            return ProductDetailCardForSale(
                              //  date: inventory.purchaseDate,
                              price: sales[i].productPrice!,
                              quantity: sales[i].quantitySold ?? 0,
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
                  });
            }),
          )
        ]),
      ),
    );
  }
}

class ProductDetailCardForSale extends StatelessWidget {
  const ProductDetailCardForSale({
    super.key,
    required this.quantity,
    required this.price,
    // required this.date
  });

  final int quantity;
  final double price;
  // final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey.shade100),
      child: ListTile(
        title: MyText(
          text: "Price: $price",
          weight: FontWeight.bold,
          size: 16,
          maxLines: 1,
        ),
        subtitle: MyText(
          text: "Qnt.: $quantity",
          color: Colors.grey,
          size: 16,
          maxLines: 1,
        ),
      ),
    );
  }
}
