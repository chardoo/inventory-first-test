import 'package:flutter/material.dart';

class MyTextFieldWithTitle extends StatelessWidget {
  MyTextFieldWithTitle({
    super.key,
    required this.name,
    required this.label,
    this.trailing,
    this.obsureText = false,
    required this.controller,
  });
  final String name;
  final String label;
  final Widget? trailing;
  final TextEditingController controller;
  final bool obsureText;
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
        MyTextField(
          controller: controller,
          label: label,
          trailing: trailing,
          obsureText: obsureText,
        )
      ],
    );
  }
}

class MyTextField extends StatelessWidget {
  MyTextField(
      {super.key,
      required this.controller,
      this.obsureText = false,
      this.trailing,
      this.label,
      this.bgColor});
  final TextEditingController controller;
  final bool obsureText;
  final Widget? trailing;
  final String? label;
  final Color? bgColor;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obsureText,
      decoration: InputDecoration(
        fillColor: bgColor,
        filled: bgColor != null,
        contentPadding: const EdgeInsets.symmetric(horizontal: 18),
        suffixIcon: trailing,
        focusedBorder: border,
        labelText: label,
        border: border,
      ),
    );
  }

  OutlineInputBorder border = OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.grey),
    borderRadius: BorderRadius.circular(8),
  );
}
