import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:rich_co_inventory/models/product.dart';
import 'package:rich_co_inventory/screens.dart/dashboard.dart';
import 'package:rich_co_inventory/widgets/button.dart';
import 'package:rich_co_inventory/widgets/drop_down_field.dart';
import 'package:rich_co_inventory/widgets/text_fields.dart';

class AddSalesScreen extends StatelessWidget {
  AddSalesScreen({super.key});
  final TextEditingController controller = TextEditingController();
  final List<Product> products = List.generate(
      5, (index) => Product(productName: "productName", price: 2342));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          title: MyText(
            text: "Add Sales",
            weight: FontWeight.bold,
            size: 24,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ProductDetails(controller: controller, products: products),
              SizedBox(height: 50),
              StockDetails(controller: controller)
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
          text: "Configure product for sale",
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
            name: "quentity sold", label: "", controller: controller),
        SizedBox(height: 24),
        MyTextFieldWithTitle(
          name: " date sold",
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
          label: "Add sales",
          ontap: () {},
          width: double.infinity,
        )
      ]),
    );
  }
}

class ProductDetails extends StatelessWidget {
  const ProductDetails({
    super.key,
    required this.controller,
    required this.products,
  });

  final TextEditingController controller;
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      padding: EdgeInsets.all(24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        DropdownField<Product>(
            items: products,
            labelText: "Gabriel shamsudeen ",
            hintText: "add a product"),
        const SizedBox(height: 50),
        DropdownField<Product>(
            items: products, labelText: "product ", hintText: "add a product"),
      ]),
    );
  }
}

class TextFieldWithDivider extends StatelessWidget {
  const TextFieldWithDivider({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("GHC"),
          VerticalDivider(),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(border: InputBorder.none),
            ),
          ),
        ],
      ),
    );
  }
}
