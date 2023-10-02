import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rich_co_inventory/helpers/navigator.dart';
import 'package:rich_co_inventory/helpers/validators.dart';
import 'package:rich_co_inventory/models/product.dart';
import 'package:rich_co_inventory/models/purchase.dart';
import 'package:rich_co_inventory/providers/product_provider.dart';
import 'package:rich_co_inventory/providers/purchase_provider.dart';
import 'package:rich_co_inventory/widgets/button.dart';
import 'package:rich_co_inventory/widgets/dialogs.dart';
import 'package:rich_co_inventory/widgets/drop_down_field.dart';
import 'package:rich_co_inventory/widgets/loading_layout.dart';
import 'package:rich_co_inventory/widgets/snac_bar.dart';
import 'package:rich_co_inventory/widgets/text_fields.dart';

import '../../widgets/texts.dart';
import '../product_feature/add_product_screen.dart';

class AddPurchaseScreen extends ConsumerStatefulWidget {
  const AddPurchaseScreen({this.purchase, super.key});
  final Purchase? purchase;
  @override
  ConsumerState<AddPurchaseScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends ConsumerState<AddPurchaseScreen> {
  final TextEditingController priceCont = TextEditingController();

  final TextEditingController quantity = TextEditingController();
  final TextEditingController purchaseDate = TextEditingController();
  final TextEditingController productCntl = TextEditingController();

  DateTime currentDate = DateTime.now();

  @override
  void initState() {
    if (widget.purchase != null) {
      final p = widget.purchase!;
      priceCont.text = p.cost.toString();
      final date = DateTime.fromMillisecondsSinceEpoch(p.purchaseDate);
      purchaseDate.text = format.format(date);
      print("date is ${purchaseDate.text}");
      quantity.text = p.quantityPurchased.toString();
      productCntl.text = p.productName;
      productInfo = (
        name: p.productName,
        productId: p.productId,
        supplierId: p.supplierId!,
        purchaseId: p.purchaseId
      );
    }
    super.initState();
  }

  ({
    String name,
    String productId,
    String supplierId,
    String? purchaseId
  })? productInfo;

  final format = DateFormat(DateFormat.YEAR_MONTH_DAY);
  @override
  void dispose() {
    priceCont.dispose();
    quantity.dispose();
    productCntl.dispose();
    purchaseDate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.purchase;
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
                                  if (product == null) {
                                    productInfo = null;
                                  }
                                },
                                controller: productCntl,
                                onSelected: (val) {
                                  if (product == null) {
                                    productInfo = (
                                      name: val.productName,
                                      productId: val.productId!,
                                      supplierId: val.supplierId!,
                                      purchaseId: null
                                    );
                                    productCntl.text = val.productName;
                                  }
                                },
                                suggestionsCallback: (val) async {
                                  return ref
                                      .read(addProductProvider.notifier)
                                      .searchProductByName(
                                          product?.productName ?? val);
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
                        if (productInfo == null) {
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
                              purchaseId: productInfo!.purchaseId,
                              time:
                                  Timestamp.fromDate(DateTime.now()).toString(),
                              productId: productInfo!.productId,
                              supplierId: productInfo!.supplierId,
                              productName: productInfo!.name,
                              purchaseDate: currentDate.millisecondsSinceEpoch,
                              quantityPurchased: int.parse(quantity.text),
                              cost: double.tryParse(priceCont.text)!);

                          final result = await ref
                              .read(purchaseProvider.notifier)
                              .addPurchase(purchase, product != null);

                          if (result.isError) {
                            if (mounted) {
                              MySnackBar.showSnack(result.error!, context);
                            }
                            return;
                          }

                          if (mounted) {
                            MyNavigator.backTo(
                              context,
                            );
                            return;
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
