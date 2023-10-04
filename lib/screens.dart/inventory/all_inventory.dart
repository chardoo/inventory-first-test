import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rich_co_inventory/helpers/navigator.dart';
import 'package:rich_co_inventory/models/stock.dart';
import 'package:rich_co_inventory/providers/inventory_provider.dart';
import 'package:rich_co_inventory/screens.dart/inventory/add_inventory.dart';
import 'package:rich_co_inventory/widgets/button.dart';
import 'package:rich_co_inventory/widgets/shimmer_loader.dart';
import 'package:rich_co_inventory/widgets/text_fields.dart';
import 'package:rich_co_inventory/widgets/texts.dart';

import '../../models/user.dart';
import '../../providers/user_provider.dart';

class AllInventory extends ConsumerStatefulWidget {
  const AllInventory({super.key});

  @override
  ConsumerState<AllInventory> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends ConsumerState<AllInventory> {
  final TextEditingController searchCtrl = TextEditingController(text: "");
  @override
  void dispose() {
    searchCtrl.dispose();
    super.dispose();
  }

  void refresh() {
    setState(() {});
    return;
  }

  Timer? timer;
  @override
  Widget build(BuildContext context) {
    final canAdd =
        ref.watch(userProvider.select((data) => data?.role != Role.user));
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
          title: const MyText(
              text: "All Inventory", weight: FontWeight.bold, size: 24)),
      body: Container(
        padding: const EdgeInsets.all(24.0),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), topRight: Radius.circular(8)),
            color: Colors.white),
        margin: const EdgeInsets.only(top: 24),
        child: Column(children: [
          SizedBox(
            height: 40,
            child: Row(
              children: [
                Expanded(
                    child: MyTextField(
                  controller: searchCtrl,
                  label: "Type stock name",
                  onChanged: (val) {
                    timer?.cancel();
                    timer = null;
                    timer = Timer(const Duration(seconds: 2), () {
                      refresh();
                    });
                  },
                )),
                const SizedBox(width: 12),
                Visibility(
                  visible: canAdd,
                  child: MyFilledIconButton(
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
                      MyNavigator.goto(context, const AddInventoryScreen());
                    },
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async => refresh(),
              child: FutureBuilder(
                  future: ref
                      .read(inventoryProvider.notifier)
                      .getInventory(searchCtrl.text),
                  builder: (_, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const ShimmerLoader();
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
                        separatorBuilder: (_, i) => const SizedBox(height: 12),
                        itemCount: snapshot.requireData.length,
                        itemBuilder: (_, i) {
                          //  return Text("richOCDE");
                          final inventory = snapshot.requireData[i];
                          return StockCard(
                            //  date: inventory.purchaseDate,
                            stock: inventory,
                          );
                        },
                      );
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

class StockCard extends ConsumerWidget {
  const StockCard({super.key, required this.stock
      // required this.date
      });

  final Stock stock;
  // final String date;

  @override
  Widget build(BuildContext context, ref) {
    final canEdit = ref.watch(
        userProvider.select((data) => data?.role == Role.superAdmin));
    print(ref.read(userProvider));
    final name =
        "${stock.productName!.substring(0, 1).toUpperCase()}${stock.productName!.substring(1)}";
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
          text: "quantity: ${stock.currentQuantity}",
          color: Colors.grey,
          size: 12,
          maxLines: 1,
        ),
        trailing: Visibility(
          visible: canEdit,
          child: GestureDetector(
            onTap: () {
              MyNavigator.goto(
                  context,
                  AddInventoryScreen(
                    stock: stock,
                  ));
            },
            child: const Icon(
              Icons.edit,
              color: Colors.blueGrey,
            ),
          ),
        ),
      ),
    );
  }
}
