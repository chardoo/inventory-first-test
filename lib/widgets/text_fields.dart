import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  MyTextField({
    super.key,
    required this.name,
    required this.label,
    this.trailing, required this.controller,
  });
  final String name;
  final String label;
  final Icon? trailing;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 7),
        TextField(controller:  controller,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 18),
            suffixIcon: trailing,
            focusedBorder: border,
            labelText: label,
            border: border,
          ),
        ),
      ],
    );
  }

  final OutlineInputBorder border = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey),
    borderRadius: BorderRadius.circular(8),
  );
}
