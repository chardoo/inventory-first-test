import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key, required this.label, this.ontap,  this.width});
  final String label;
  final Function()? ontap;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: FilledButton(
          style: FilledButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8))),
          onPressed: ontap,
          child: Text(label)),
    );
  }
}


class MyFilledIconButton extends StatelessWidget {
  const MyFilledIconButton({
    super.key,
    required this.icon,
    required this.label,
    this.ontap,
  });

  final Widget icon;
  final Widget label;
  final Function()? ontap;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
        style: FilledButton.styleFrom(
            foregroundColor: Colors.blue,
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.circular(8))),
        onPressed: ontap,
        icon: icon,
        label: label);
  }
}