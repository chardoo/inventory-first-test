import 'package:flutter/material.dart';

class MyTextFieldWithTitle extends StatelessWidget {
  MyTextFieldWithTitle(
      {super.key,
      required this.name,
      required this.label,
      this.trailing,
      this.obsureText = false,
      this.readOnly,
      required this.controller,
      this.lines,
      this.ontap});
  final String name;
  final String label;
  final Widget? trailing;
  final TextEditingController controller;
  final bool obsureText;
  final int? lines;
  final bool? readOnly;
  final Function()? ontap;
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
          readOnly: readOnly,
          ontap: ontap,
          trailing: trailing,
          line: lines,
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
      this.line,
      this.readOnly,
      this.ontap,
      this.bgColor});
  final TextEditingController controller;
  final bool obsureText;
  final bool? readOnly;
  final Widget? trailing;
  final String? label;
  final Color? bgColor;
  final int? line;
  final Function()? ontap;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obsureText,
      maxLines: line,
      onTap: ontap,
      readOnly: readOnly ?? false,
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
