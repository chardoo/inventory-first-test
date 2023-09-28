import 'package:flutter/material.dart';
import 'package:rich_co_inventory/models/product.dart';
import 'package:rich_co_inventory/widgets/button.dart';
import 'package:rich_co_inventory/widgets/text_fields.dart';

import '../../widgets/texts.dart';

class AddSalesPerson extends StatelessWidget {
  AddSalesPerson({super.key});
  final TextEditingController controller = TextEditingController();
  final List<Product> products = List.generate(
      5, (index) => const Product(productName: "productName", price: 2342));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          title: const MyText(
            text: "Add Sales Person",
            weight: FontWeight.bold,
            size: 24,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Container(
              padding: const EdgeInsets.all(24),
              color: Colors.white,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const MyText(
                        text: "Profile details",
                        size: 24,
                        weight: FontWeight.bold),
                    const SizedBox(height: 24),
                    MyTextFieldWithTitle(
                      name: " date sold",
                      label: "name of person",
                      controller: controller,
                    ),
                    const SizedBox(height: 24),
                    MyTextFieldWithTitle(
                      name: " date sold",
                      label: "email",
                      controller: controller,
                    ),
                    const SizedBox(height: 24),
                    const MyText(
                      text: "contact number",
                      weight: FontWeight.bold,
                      size: 16,
                    ),
                    TextFieldWithDivider(controller: controller),
                    const SizedBox(height: 24),
                    MyTextFieldWithTitle(
                      name: "hire date",
                      label: "",
                      controller: controller,
                      readOnly: true,
                      ontap: () {
                        showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate:
                                DateTime.now().subtract(const Duration(days: 1000)),
                            lastDate: DateTime.now().add(const Duration(days: 1000)));
                      },
                      trailing: const Icon(Icons.calendar_month),
                    ),
                    const SizedBox(height: 24),
                    CustomButton(
                        label: "Create person",
                        ontap: () {},
                        width: double.infinity)
                  ]),
            ),
          ),
        ));
  }
}

