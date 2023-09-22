import 'package:flutter/material.dart';
import 'package:rich_co_inventory/widgets/text_fields.dart';
import 'package:rich_co_inventory/widgets/texts.dart';

import 'button.dart';

class MyDialogWithTitles extends StatelessWidget {
  const MyDialogWithTitles({
    super.key,
    required this.labels,
    required this.hintText,
    required this.controllers,
    this.onComplete,
    required this.title,
  }) : assert(labels.length == hintText.length &&
            labels.length == controllers.length);

  final List<String> labels;
  final List<String> hintText;
  final List<TextEditingController> controllers;
  final Function()? onComplete;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          child: Dialog(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Wrap(
                  alignment: WrapAlignment.center,
                  runSpacing: 24,
                  children: [
                    MyText(
                      text: title,
                      weight: FontWeight.bold,
                      size: 24,
                    ),
                    ...List.generate(
                        labels.length,
                        (int i) => MyTextFieldWithTitle(
                            name: labels[i],
                            label: hintText[i],
                            controller: controllers[i])),
                    CustomButton(
                      label: "Add",
                      ontap: onComplete,
                    )
                  ]),
            ),
          ),
        ),
      ],
    );
  }
}
