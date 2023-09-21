import 'package:flutter/material.dart';
import 'package:rich_co_inventory/widgets/text_fields.dart';

class AddProductScreen extends StatelessWidget {
  AddProductScreen({super.key});
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: MyTextField(
            controller: controller,
            bgColor: Colors.grey.shade200,
            label: "Name",
          ),
        ));
  }
}
