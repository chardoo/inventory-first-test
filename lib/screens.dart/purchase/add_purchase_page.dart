import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rich_co_inventory/helpers/navigator.dart';
import 'package:rich_co_inventory/models/brand.dart';
import 'package:rich_co_inventory/models/product.dart';
import 'package:rich_co_inventory/models/purchase.dart';
import 'package:rich_co_inventory/models/stock.dart';
import 'package:rich_co_inventory/models/supplier.dart';
import 'package:rich_co_inventory/providers/product_provider.dart';
import 'package:rich_co_inventory/providers/app_state_provider.dart';
import 'package:rich_co_inventory/providers/purchase_provider.dart';
import 'package:rich_co_inventory/screens.dart/add_product_screen.dart';
import 'package:rich_co_inventory/widgets/button.dart';
import 'package:rich_co_inventory/widgets/drop_down_field.dart';
import 'package:rich_co_inventory/widgets/text_fields.dart';

import '../../widgets/dropdown_with_labels.dart';
import '../../widgets/texts.dart';

class AddPurchaseScreen extends ConsumerStatefulWidget {
  AddPurchaseScreen({super.key});

  @override
  ConsumerState<AddPurchaseScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends ConsumerState<AddPurchaseScreen> {
  final TextEditingController productController = TextEditingController();

  final TextEditingController brandController = TextEditingController();

  final TextEditingController supplierController = TextEditingController();

  final TextEditingController productDescriptionCont = TextEditingController();
  final TextEditingController priceCont = TextEditingController();

  final TextEditingController price = TextEditingController();
  final TextEditingController quantity = TextEditingController();
  final TextEditingController purchaseDate = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController product = TextEditingController();
  final TextEditingController productid = TextEditingController();
   final TextEditingController supplierId = TextEditingController();
      final TextEditingController productName = TextEditingController();
  DateTime currentDate = DateTime.now();
  final format = DateFormat(DateFormat.YEAR_MONTH_DAY);
  @override
  void dispose() {
    productController.dispose();
    brandController.dispose();
    supplierController.dispose();
    productController.dispose();
    priceCont.dispose();

    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    purchaseDate.text = format.format(currentDate);
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          title: const MyText(
            text: "Add Purchase",
            weight: FontWeight.bold,
            size: 24,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const MyText(text: "Select Product"),
              Row(
                children: [
                  Expanded(
                      child: SearchDropDownMenu<Product>(
                          context: context,
                          itemBuilder: (context, value) {
                            return ListTile(title: Text(value.productName));
                          },
                          controller: product,
                          onSelected: (val) {
                            product.text = val.productName;
                            // print("hello my product id");
                            // print(val.productId!);
                            supplierId.text = val.supplierId!;
                            productid.text = val.productId!;
                            productName.text = val.productName!;
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
                      icon: Icon(Icons.add),
                      label: Text("New"),
                      ontap: () {
                        // showDialog(
                        //     context: context,
                        //     builder: (_) {
                        //       return const _AddSupplierDialog();
                        //     });
                          MyNavigator.goto(context, AddProductScreen());
                      })
                ],
              ),
              const SizedBox(height: 24),
              MyTextFieldWithTitle(
                  name: "cost of One", label: "", controller: price),
              const SizedBox(height: 24),
              MyTextFieldWithTitle(
                  name: "Quantity", label: "", controller: quantity),
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
                      firstDate:
                          DateTime.now().subtract(const Duration(days: 1000)),
                      lastDate: DateTime.now().add(const Duration(days: 1000)));
                  setState(() {
                    currentDate = selectedDate ?? currentDate;
                  });
                },
                trailing: const Icon(Icons.calendar_month),
              ),
              SizedBox(
                height: 50,
              ),
              CustomButton(
                label: "Add Purchase",
                width: double.infinity,
                ontap: () async{
                  Purchase purchase = Purchase( productId: productid.text,supplierId: supplierId.text!, productName: productName.text, purchaseDate: currentDate.millisecondsSinceEpoch, quantityPurchased: int.parse( quantity.text), cost: double.tryParse(price.text)!);
                    
                    ref.read(purchaseProvider.notifier).addPurchase(purchase);
                },
              )
            ]),
          ),
        ));
  }
}
