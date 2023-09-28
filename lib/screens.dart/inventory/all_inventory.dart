import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rich_co_inventory/helpers/navigator.dart';
import 'package:rich_co_inventory/providers/display_products_provider.dart';
import 'package:rich_co_inventory/screens.dart/inventory/add_inventory.dart';
import 'package:rich_co_inventory/widgets/button.dart';
import 'package:rich_co_inventory/widgets/text_fields.dart';
import 'package:rich_co_inventory/widgets/texts.dart';

class AllInventory extends ConsumerStatefulWidget {
  const AllInventory({super.key});

  @override
  ConsumerState<AllInventory> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends ConsumerState<AllInventory> {
  @override
  void initState() {
    Future.microtask(
        () => ref.read(displayProductsProvider.notifier).getStocks());
    super.initState();
  }

  final TextEditingController searchCtrl = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
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
                  MyNavigator.goto(context, const AddInventoryScreen());
                },
              )
            ],
          ),
          const SizedBox(height: 24),
          Consumer(builder: (_, ref, __) {
            return ref.watch(displayProductsProvider).display();
          })
        ]),
      ),
    );
  }
}

class PurchaseCard extends StatelessWidget {
  const PurchaseCard({
    super.key,
    required this.productName,
    required this.quantity,
    // required this.date
  });

  final String productName;
  final int quantity;
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
          text: productName,
          weight: FontWeight.bold,
          size: 16,
          maxLines: 1,
        ),
        subtitle: MyText(
          text: "Qnt: $quantity",
          color: Colors.grey,
          size: 16,
          maxLines: 1,
        ),
        trailing: const Icon(
          Icons.edit,
          color: Colors.blueGrey,
        ),
      ),
    );
  }
}
