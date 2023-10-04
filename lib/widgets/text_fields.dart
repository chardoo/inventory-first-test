import 'package:flutter/material.dart';

class MyTextFieldWithTitle extends StatelessWidget {
  const MyTextFieldWithTitle(
      {super.key,
      required this.name,
      required this.label,
      this.trailing,
      // this.obsureText = false,
      this.readOnly,
      this.controller,
      this.lines,
      this.ontap,
      this.onChanged,
      this.onEditingComplete,
      this.keyboadType});
  final String name;
  final String label;
  final Widget? trailing;
  final Function(String val)? onChanged;
  final Function()? onEditingComplete;
  final TextInputType? keyboadType;

  final TextEditingController? controller;
  // final bool obsureText;
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
        const SizedBox(height: 7),
        MyTextField(
          controller: controller,
          label: label, keyboadType: keyboadType,
          onChanged: onChanged,
          readOnly: readOnly, onEditingComplete: onEditingComplete,
          ontap: ontap,
          trailing: trailing,
          line: lines,
          // obsureText: obsureText,
        )
      ],
    );
  }
}

// ignore: must_be_immutable
class MyTextField extends StatelessWidget {
  MyTextField(
      {super.key,
      this.controller,
      this.onChanged,
      // this.obsureText = false,
      this.trailing,
      this.label,
      this.line,
      this.readOnly,
      this.ontap,
      this.bgColor,
      this.onEditingComplete,
      this.keyboadType});
  final TextEditingController? controller;
  // final bool obsureText;
  final bool? readOnly;
  final Widget? trailing;
  final TextInputType? keyboadType;
  final String? label;
  final Color? bgColor;
  final int? line;
  final Function()? ontap;
  final Function(String val)? onChanged;
  final Function()? onEditingComplete;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboadType ?? TextInputType.text,
      //obscureText: obsureText,
      maxLines: line,

      onEditingComplete: onEditingComplete,
      onTap: ontap,
      readOnly: readOnly ?? false,
      onChanged: onChanged,
      decoration: InputDecoration(
        fillColor: bgColor,
        filled: bgColor != null,
        contentPadding: EdgeInsets.symmetric(
            horizontal: 18, vertical: line != null && line! > 1 ? 10 : 0),
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

class TextFieldWithDivider extends StatelessWidget {
  const TextFieldWithDivider(
      {super.key,
      this.controller,
      this.enabled = true,
      this.label,
      this.onChanged});

  final TextEditingController? controller;
  final String? label;
  final bool enabled;
  final Function(String val)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("GHC"),
          const VerticalDivider(),
          Expanded(
            child: TextField(
              controller: controller,
              enabled: enabled,
              onChanged: onChanged,
              decoration:
                  InputDecoration(border: InputBorder.none, labelText: label),
            ),
          ),
        ],
      ),
    );
  }
}
