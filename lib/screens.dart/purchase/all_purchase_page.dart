import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rich_co_inventory/helpers/navigator.dart';
import 'package:rich_co_inventory/providers/purchase_provider.dart';
import 'package:rich_co_inventory/screens.dart/purchase/add_purchase_page.dart';
import 'package:rich_co_inventory/widgets/button.dart';
import 'package:rich_co_inventory/widgets/shimmer.dart';
import 'package:rich_co_inventory/widgets/text_fields.dart';
import 'package:rich_co_inventory/widgets/texts.dart';

class AllPurchaseScreen extends StatefulWidget {
  const AllPurchaseScreen({super.key});

  @override
  State<AllPurchaseScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<AllPurchaseScreen> {
  final TextEditingController searchCtrl = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
          title: const MyText(
              text: "All Purchases", weight: FontWeight.bold, size: 24)),
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
                label: "Type item name",
                onChanged: (val) {
                  searchCtrl.text = val;
                  setState(() {});
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
                  MyNavigator.goto(context, const AddPurchaseScreen());
                },
              )
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Consumer(builder: (context, ref, _) {
              return FutureBuilder(
                  future: ref
                      .read(purchaseProvider.notifier)
                      .getPurchases(searchCtrl.text),
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
                            text: "No purchase yet",
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
                            //  return Text("richOCDE");
                            final purchase = snapshot.requireData[i];
                            return PurchaseCard(
                                date: DateTime.fromMillisecondsSinceEpoch(
                                        purchase.purchaseDate)
                                    .toString(),
                                productName: purchase.productName,
                                quantity: purchase.quantityPurchased,
                                price:   purchase.cost);
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

class PurchaseCard extends StatelessWidget {
  const PurchaseCard(
      {super.key,
      required this.productName,
      required this.quantity,
      required this.price,
      required this.date});

  final String productName;
  final int quantity;
  final double price;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey.shade100),
      child: ListTile(
        title: MyText(
          text: productName,
          weight: FontWeight.bold,
          size: 16,
          maxLines: 1,
        ),
        leading: Column(
          children: [
            MyText(
              text: "cost:$price",
              weight: FontWeight.bold,
              size: 16,
              maxLines: 1,
            ),
            MyText(
              text: "Qnt: $quantity",
              weight: FontWeight.bold,
              size: 16,
              maxLines: 1,
            ),
          ],
        ),
        subtitle: MyText(
          text: date,
          size: 14,
          maxLines: 1,
          color: Colors.blueGrey,
        ),
        trailing: const Icon(
          Icons.edit,
          color: Colors.blueGrey,
        ),
      ),
    );
  }
}
