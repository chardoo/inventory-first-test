import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:rich_co_inventory/models/product.dart';
import 'package:rich_co_inventory/screens.dart/dashboard.dart';
import 'package:rich_co_inventory/widgets/button.dart';
import 'package:rich_co_inventory/widgets/drop_down_field.dart';
import 'package:rich_co_inventory/widgets/text_fields.dart';

class AddProductScreen extends StatelessWidget {
  AddProductScreen({super.key});
  final TextEditingController controller = TextEditingController();
  final List<Product> products = List.generate(
      5, (index) => Product(productName: "productName", price: 2342));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          title: MyText(
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
        MyTextFieldWithTitle(
            name: "Product name",
            label: "eg. coca cola",
            controller: controller),
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
                onPressed: () {},
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
            controller: controller)
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
