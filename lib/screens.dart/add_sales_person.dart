import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:rich_co_inventory/models/product.dart';
import 'package:rich_co_inventory/screens.dart/dashboard.dart';
import 'package:rich_co_inventory/widgets/button.dart';
import 'package:rich_co_inventory/widgets/drop_down_field.dart';
import 'package:rich_co_inventory/widgets/text_fields.dart';

import '../widgets/texts.dart';

class AddSalesPerson extends StatelessWidget {
  AddSalesPerson({super.key});
  final TextEditingController controller = TextEditingController();
  final List<Product> products = List.generate(
      5, (index) => Product(productName: "productName", price: 2342));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          title: MyText(
            text: "Add Sales Person",
            weight: FontWeight.bold,
            size: 24,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Container(
              padding: EdgeInsets.all(24),
              color: Colors.white,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                        text: "Profile details",
                        size: 24,
                        weight: FontWeight.bold),
                    SizedBox(height: 24),
                    MyTextFieldWithTitle(
                      name: " date sold",
                      label: "name of person",
                      controller: controller,
                    ),
                    SizedBox(height: 24),
                    MyTextFieldWithTitle(
                      name: " date sold",
                      label: "email",
                      controller: controller,
                    ),
                    SizedBox(height: 24),
                    MyText(
                      text: "contact number",
                      weight: FontWeight.bold,
                      size: 16,
                    ),
                    TextFieldWithDivider(controller: controller),
                    SizedBox(height: 24),
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
                                DateTime.now().subtract(Duration(days: 1000)),
                            lastDate: DateTime.now().add(Duration(days: 1000)));
                      },
                      trailing: Icon(Icons.calendar_month),
                    ),
                    SizedBox(height: 24),
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

