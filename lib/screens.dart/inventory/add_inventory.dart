import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rich_co_inventory/helpers/navigator.dart';
import 'package:rich_co_inventory/models/product.dart';
import 'package:rich_co_inventory/models/stock.dart';
import 'package:rich_co_inventory/providers/show_items_provider.dart';
import 'package:rich_co_inventory/providers/inventory_provider.dart';
import 'package:rich_co_inventory/providers/product_provider.dart';
import 'package:rich_co_inventory/screens.dart/shared/widgets/button.dart';
import 'package:rich_co_inventory/screens.dart/shared/widgets/drop_down_field.dart';
import 'package:rich_co_inventory/screens.dart/shared/widgets/loading_layout.dart';
import 'package:rich_co_inventory/screens.dart/shared/widgets/snac_bar.dart';
import 'package:rich_co_inventory/screens.dart/shared/widgets/text_fields.dart';

import '../../helpers/validators.dart';
import '../shared/widgets/texts.dart';
import '../product_feature/add_product_screen.dart';

class AddInventoryScreen extends ConsumerStatefulWidget {
  const AddInventoryScreen({super.key});

  @override
  ConsumerState<AddInventoryScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends ConsumerState<AddInventoryScreen> {
  final TextEditingController productController = TextEditingController();

  final TextEditingController quantityCntl = TextEditingController();
  final TextEditingController purchaseDate = TextEditingController();

  DateTime currentDate = DateTime.now();
  final format = DateFormat(DateFormat.YEAR_MONTH_DAY);
  @override
  void dispose() {
    quantityCntl.dispose();
    purchaseDate.dispose();
    productController.dispose();

    super.dispose();
  }

  Product? selectedProduct;

  var error = (true, "");
  @override
  Widget build(BuildContext context) {
    purchaseDate.text = format.format(currentDate);
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          leading: BackButton(
              color: Colors.black, onPressed: () => MyNavigator.back(context)),
          title: const MyText(
            text: "Add Inventory",
            weight: FontWeight.bold,
            size: 24,
          ),
        ),
        body: LoadingLayout(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const MyText(text: "Select Product"),
                    Row(
                      children: [
                        Expanded(
                            child: SearchDropDownMenu<Product>(
                                context: context,
                                itemBuilder: (context, value) {
                                  return ListTile(
                                      title: Text(value.productName));
                                },
                                controller: productController,
                                onChange: (val) {
                                  print("val $val");
                                  selectedProduct = null;
                                },
                                onSelected: (val) {
                                  selectedProduct = val;
                                  productController.text = val.productName;
                                },
                                suggestionsCallback: (val) async {
                                  return ref
                                      .read(addProductProvider.notifier)
                                      .searchProductByName(val);
                                })),
                        const SizedBox(
                          width: 12,
                        ),
                        MyFilledIconButton(
                            icon: const Icon(Icons.add),
                            label: const Text("New"),
                            ontap: () {
                              MyNavigator.goto(
                                  context, const AddProductScreen());
                            })
                      ],
                    ),
                    const SizedBox(height: 24),
                    const SizedBox(height: 24),
                    Visibility(
                      visible: error.$1,
                      child: MyText(
                        text: error.$2,
                        color: Colors.redAccent,
                      ),
                    ),
                    MyTextFieldWithTitle(
                        name: "Quantity to Add",
                        label: "",
                        onChanged: (val) {
                          setState(() {
                            error = MyValidators.isNotNumberAndIsEmpty(val);
                          });
                        },
                        keyboadType: TextInputType.number,
                        controller: quantityCntl),
                    const SizedBox(height: 24),
                    MyTextFieldWithTitle(
                      name: "Select Date",
                      label: "",
                      controller: purchaseDate,
                      readOnly: true,
                      ontap: () async {
                        final selectedDate = await showDatePicker(
                            currentDate: currentDate,
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now()
                                .subtract(const Duration(days: 1000)),
                            lastDate:
                                DateTime.now().add(const Duration(days: 1000)));
                        setState(() {
                          currentDate = selectedDate ?? currentDate;
                        });
                      },
                      trailing: const Icon(Icons.calendar_month),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    CustomButton(
                      label: "Add Inventory",
                      width: double.infinity,
                      ontap: () async {
                        if (selectedProduct == null) {
                          MySnackBar.showSnack(
                              "please select a product", context);
                          return;
                        }
                        error = MyValidators.isNotNumberAndIsEmpty(
                            quantityCntl.text);
                        if (error.$1) {
                          MySnackBar.showSnack(error.$2, context);
                        }
                        Stock purchase = Stock(
                          productId: selectedProduct!.productId!,
                          productName: selectedProduct!.productName,
                          currentQuantity: int.parse(quantityCntl.text),
                          minimumRequiredQuantity: int.parse(quantityCntl.text),
                        );
                        ref
                            .read(inventoryProvider.notifier)
                            .addInventory(purchase);

                        MyNavigator.back(context);
                        ref.read(displayProductsProvider.notifier).getStocks();
                      },
                    )
                  ]),
            ),
          ),
        ));
  }
}
