import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rich_co_inventory/models/brand.dart';
import 'package:rich_co_inventory/models/product.dart';
import 'package:rich_co_inventory/models/supplier.dart';
import 'package:rich_co_inventory/providers/app_state_provider.dart';
import 'package:rich_co_inventory/providers/supplier_api_helper.dart';
import 'package:rich_co_inventory/widgets/button.dart';
import 'package:rich_co_inventory/widgets/drop_down_field.dart';
import 'package:rich_co_inventory/widgets/text_fields.dart';

import '../widgets/texts.dart';

class AddProductScreen extends StatelessWidget {
  AddProductScreen({super.key});
  final List<Product> products = List.generate(
      5, (index) => Product(productName: "productName", price: 2342));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          title: const MyText(
            text: "Add product",
            weight: FontWeight.bold,
            size: 24,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ProductDetails(),
              SizedBox(height: 50),
              StockDetails(controller: TextEditingController())
            ]),
          ),
        ));
  }
}

class StockDetails extends StatelessWidget {
  const StockDetails({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      padding: EdgeInsets.all(24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const MyText(
          text: "Configure stock for this product",
          size: 24,
          weight: FontWeight.bold,
        ),
        SizedBox(height: 24),
        const MyText(
          text: "product cost",
          weight: FontWeight.bold,
          size: 16,
        ),
        SizedBox(height: 12),
        TextFieldWithDivider(
          controller: controller,
        ),
        SizedBox(height: 24),
        MyTextFieldWithTitle(
            name: "initial Stock", label: "", controller: controller),
        SizedBox(height: 24),
        MyTextFieldWithTitle(
          name: "input date",
          label: "",
          controller: controller,
          readOnly: true,
          ontap: () {
            showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now().subtract(Duration(days: 1000)),
                lastDate: DateTime.now().add(Duration(days: 1000)));
          },
          trailing: Icon(Icons.calendar_month),
        ),
        SizedBox(height: 50),
        CustomButton(
          label: "Add product",
          ontap: () {},
          width: double.infinity,
        )
      ]),
    );
  }
}

class ProductDetails extends StatefulWidget {
  ProductDetails({
    super.key,
  });

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final productController = TextEditingController();

  final brandController = TextEditingController();

  final supplierController = TextEditingController();

  final products = List.generate(
      5, (index) => const Product(productName: 'productName', price: 3232));
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      padding: EdgeInsets.all(24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        MyTextFieldWithTitle(
            name: "Product name",
            label: "eg. coca cola",
            controller: productController),
        const SizedBox(height: 12),
        MyText(text: "Supplier"),
        Row(
          children: [
            Expanded(
              child: DropdownField<Product>(
                  items: products,
                  labelText: "product ",
                  hintText: "add a product"),
            ),
            SizedBox(
              width: 12,
            ),
            FilledButton.icon(
                style: FilledButton.styleFrom(
                    foregroundColor: Colors.blue,
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(8))),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return const _AddSupplierDialog();
                      });
                },
                icon: Icon(Icons.add),
                label: Text("New"))
          ],
        ),
        SizedBox(height: 12),
        MyText(text: "brand"),
        Row(
          children: [
            Expanded(
              child: DropdownField<Product>(
                  items: products,
                  labelText: "product ",
                  hintText: "add a product"),
            ),
            SizedBox(
              width: 12,
            ),
            FilledButton.icon(
                style: FilledButton.styleFrom(
                    foregroundColor: Colors.blue,
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(8))),
                onPressed: () {},
                icon: Icon(Icons.add),
                label: Text("New"))
          ],
        ),
        const SizedBox(height: 12),
        MyTextFieldWithTitle(
            name: "name",
            label: "Type something",
            lines: 3,
            controller: TextEditingController())
      ]),
    );
  }
}

class _AddSupplierDialog extends ConsumerStatefulWidget {
  const _AddSupplierDialog({
    super.key,
  });

  @override
  ConsumerState<_AddSupplierDialog> createState() => _AddSupplierDialogState();
}

class _AddSupplierDialogState extends ConsumerState<_AddSupplierDialog> {
  final nameCont = TextEditingController();

  final emailCont = TextEditingController();

  final addressCont = TextEditingController();

  final contactCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Dialog(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                MyText(text: "Create Supplier"),
                MyTextFieldWithTitle(
                    name: "name",
                    label: "enter supplier name",
                    controller: nameCont),
                MyTextFieldWithTitle(
                    name: "contact",
                    label: "enter contact",
                    controller: contactCont),
                MyTextFieldWithTitle(
                    name: "address",
                    label: "enter supplier contact",
                    controller: addressCont),
                MyTextFieldWithTitle(
                    name: "email",
                    label: "enter supplier email",
                    controller: emailCont),
                CustomButton(
                  label: "Add",
                  ontap: () async{
                    Supplier supplier = Supplier(
                        supplierName: nameCont.text,
                        supplierEmail: emailCont.text,
                        supplierContact: contactCont.text,
                        supplierAddress: addressCont.text);
                    SupplierApisHelper().addBrand(supplier, ref);
                  },
                )
              ]),
            ),
          ),
        ),
        ref.watch(loadingStateProvider).show(context)
      ],
    );
  }
}
