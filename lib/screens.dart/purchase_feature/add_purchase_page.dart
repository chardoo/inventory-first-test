import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rich_co_inventory/helpers/navigator.dart';
import 'package:rich_co_inventory/helpers/validators.dart';
import 'package:rich_co_inventory/models/product.dart';
import 'package:rich_co_inventory/models/purchase.dart';
import 'package:rich_co_inventory/providers/product_provider.dart';
import 'package:rich_co_inventory/providers/purchase_provider.dart';
import 'package:rich_co_inventory/screens.dart/shared/widgets/button.dart';
import 'package:rich_co_inventory/screens.dart/shared/widgets/dialogs.dart';
import 'package:rich_co_inventory/screens.dart/shared/widgets/drop_down_field.dart';
import 'package:rich_co_inventory/screens.dart/shared/widgets/loading_layout.dart';
import 'package:rich_co_inventory/screens.dart/shared/widgets/snac_bar.dart';
import 'package:rich_co_inventory/screens.dart/shared/widgets/text_fields.dart';

import '../shared/widgets/texts.dart';
import '../product_feature/add_product_screen.dart';

class AddPurchaseScreen extends ConsumerStatefulWidget {
  const AddPurchaseScreen({super.key});

  @override
  ConsumerState<AddPurchaseScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends ConsumerState<AddPurchaseScreen> {
  final TextEditingController priceCont = TextEditingController();

  final TextEditingController quantity = TextEditingController();
  final TextEditingController purchaseDate = TextEditingController();
  final TextEditingController productCntl = TextEditingController();
  final TextEditingController productName = TextEditingController();
  DateTime currentDate = DateTime.now();
  final format = DateFormat(DateFormat.YEAR_MONTH_DAY);
  @override
  void dispose() {
    priceCont.dispose();
    quantity.dispose();
    productCntl.dispose();
    purchaseDate.dispose();
    productName.dispose();
    super.dispose();
  }

  Product? selectedProduct;
  @override
  Widget build(BuildContext context) {
    purchaseDate.text = format.format(currentDate);
    return LoadingLayout(
      child: Scaffold(
          backgroundColor: Colors.grey.shade100,
          appBar: AppBar(
            leading: const BackButton(color: Colors.black),
            title: const MyText(
              text: "Add Purchase",
              weight: FontWeight.bold,
              size: 24,
            ),
          ),
          body: SingleChildScrollView(
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
                                onChange: (val) {
                                  selectedProduct = null;
                                },
                                controller: productCntl,
                                onSelected: (val) {
                                  selectedProduct = val;
                                  productCntl.text = val.productName;
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
                    MyTextFieldWithTitle(
                        keyboadType: TextInputType.number,
                        name: "cost of One",
                        label: "",
                        controller: priceCont),
                    const SizedBox(height: 24),
                    MyTextFieldWithTitle(
                        keyboadType: TextInputType.number,
                        name: "Quantity",
                        label: "",
                        controller: quantity),
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
                      label: "Add Purchase",
                      width: double.infinity,
                      ontap: () async {
                        if (selectedProduct == null) {
                          MySnackBar.showSnack(
                              "please select a product", context);
                          return;
                        }
                        final costValidator =
                            MyValidators.isNotNumberAndIsEmpty(priceCont.text,
                                name: "price");
                        final quantityValidator =
                            MyValidators.isNotNumberAndIsEmpty(quantity.text,
                                name: "quantity");
                        if (costValidator.$1) {
                          MySnackBar.showSnack(costValidator.$2, context);
                          return;
                        }
                        if (quantityValidator.$1) {
                          MySnackBar.showSnack(quantityValidator.$2, context);
                          return;
                        }

                        MyDialogs.showConfirm(context,
                        title: "Add a Purchase",
                            message: "Do u really want to add this purchase",
                          
                            onAcceptLabel: () async {
                          MyNavigator.back(context);
                          Purchase purchase = Purchase(
                              productId: selectedProduct!.productId!,
                              supplierId: selectedProduct!.supplierId,
                              productName: selectedProduct!.productName,
                              purchaseDate: currentDate.millisecondsSinceEpoch,
                              quantityPurchased: int.parse(quantity.text),
                              cost: double.tryParse(priceCont.text)!);

                          await ref
                              .read(purchaseProvider.notifier)
                              .addPurchase(purchase);
                          if (mounted) {
                            MyNavigator.backTo(
                              context,
                            );
                          }
                        });
                      },
                    )
                  ]),
            ),
          )),
    );
  }
}
