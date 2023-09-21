import 'package:flutter/material.dart';

import '../../../models/product.dart';
import '../../../widgets/drop_down_field.dart';
import '../../../widgets/text_fields.dart';
import '../../../widgets/texts.dart';
import '../../dashboard.dart';

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
