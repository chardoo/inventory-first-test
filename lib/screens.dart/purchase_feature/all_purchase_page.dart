import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:rich_co_inventory/helpers/navigator.dart';
import 'package:rich_co_inventory/helpers/string_helper.dart';
import 'package:rich_co_inventory/models/purchase.dart';
import 'package:rich_co_inventory/providers/show_items_provider.dart';
import 'package:rich_co_inventory/providers/purchase_provider.dart';
import 'package:rich_co_inventory/screens.dart/purchase_feature/add_purchase_page.dart';
import 'package:rich_co_inventory/widgets/button.dart';
import 'package:rich_co_inventory/widgets/shimmer.dart';
import 'package:rich_co_inventory/widgets/text_fields.dart';
import 'package:rich_co_inventory/widgets/texts.dart';

import '../../widgets/shimmer_loader.dart';

class AllPurchaseScreen extends ConsumerStatefulWidget {
  const AllPurchaseScreen({super.key});

  @override
  ConsumerState<AllPurchaseScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends ConsumerState<AllPurchaseScreen> {
  final TextEditingController searchCtrl = TextEditingController(text: "");

  void refresh() {
    setState(() {});
    return;
  }

  Timer? timer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
          title: const MyText(
              text: "All  Purchases", weight: FontWeight.bold, size: 24)),
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
                  MyNavigator.goto(context, const AddPurchaseScreen());
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
                      .read(purchaseProvider.notifier)
                      .getPurchases(searchCtrl.text),
                  builder: (_, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const ShimmerLoader();
                    }

                    if (snapshot.hasData) {
                      if (snapshot.requireData.isEmpty) {
                        return const Center(
                          child: MyText(
                            text: "No Purchases yet",
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
                            final purchase = snapshot.requireData[i];
                            return _PurchaseCard(
                              purchase: purchase,
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

class _PurchaseCard extends StatelessWidget {
  const _PurchaseCard({super.key, required this.purchase});

  final Purchase purchase;
  format(int dateInt) {
    final date = DateTime.fromMillisecondsSinceEpoch(purchase.purchaseDate);
    final format = DateFormat(DateFormat.YEAR_ABBR_MONTH_WEEKDAY_DAY);
    final timeFormat = DateFormat(DateFormat.HOUR_MINUTE);
    return "${format.format(date)} ${timeFormat.format(date)}";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey.shade100),
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(
            children: [
              MyText(
                text: "cost: ${purchase.cost}".nameCase,
                weight: FontWeight.bold,
                size: 16,
                maxLines: 1,
              ),
              const SizedBox(height: 8),
              MyText(
                text: "quantity: ${purchase.quantityPurchased}",
                size: 14,
                maxLines: 1,
                color: Colors.blueGrey,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(
                text: purchase.productName.nameCase,
                weight: FontWeight.bold,
                size: 16,
                maxLines: 1,
              ),
              const SizedBox(height: 8),
              MyText(
                text: format(purchase.purchaseDate),
                size: 14,
                maxLines: 1,
                color: Colors.blueGrey,
              )
            ],
          ),
          GestureDetector(
            onTap: () {
              MyNavigator.goto(
                  context,
                  AddPurchaseScreen(
                    purchase: purchase,
                  ));
            },
            child: const Icon(
              Icons.edit,
              color: Colors.blueGrey,
            ),
          ),
        ]),
      ),
      // child: ListTile(
      // title:
      // leading:
      // trailing:
      // ),
    );
  }
}
