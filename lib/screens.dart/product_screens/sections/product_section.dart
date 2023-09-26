import 'package:flutter/material.dart';

import '../../../models/product.dart';
import '../../../widgets/drop_down_field.dart';
import '../../../widgets/text_fields.dart';
import '../../../widgets/texts.dart';

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
      padding: const EdgeInsets.all(24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        MyTextFieldWithTitle(
            name: "Product name",
            label: "eg. coca cola",
            controller: controller),
        const SizedBox(height: 12),
        const MyText(text: "Supplier"),
        Row(
          children: [
            Expanded(
                child: SearchDropDownMenu<Product>(
                    context: context,
                    itemBuilder: (context, value) {
                      return Text(value.productName);
                    },
                    controller: controller,
                    onSelected: (val) {
                      controller.text = val.productName;
                    },
                    suggestionsCallback: (val) {})),
            const SizedBox(
              width: 12,
            ),
            FilledButton.icon(
                style: FilledButton.styleFrom(
                    foregroundColor: Colors.blue,
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(8))),
                onPressed: () {},
                icon: const Icon(Icons.add),
                label: const Text("New"))
          ],
        ),
        const SizedBox(height: 12),
        const MyText(text: "brand"),
        Row(
          children: [
            SearchDropDownMenu<Product>(
                context: context,
                itemBuilder: (context, value) {
                  return Text(value.productName);
                },
                controller: controller,
                onSelected: (val) {
                  controller.text = val.productName;
                },
                suggestionsCallback: (val) {}),
            const SizedBox(
              width: 12,
            ),
            FilledButton.icon(
                style: FilledButton.styleFrom(
                    foregroundColor: Colors.blue,
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(8))),
                onPressed: () {},
                icon: const Icon(Icons.add),
                label: const Text("New"))
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
