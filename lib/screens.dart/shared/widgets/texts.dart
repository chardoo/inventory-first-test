import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  const MyText({
    super.key,
    required this.text,
    this.color,
    this.size,
    this.weight, this.maxLines,
  });
  final String text;
  final Color? color;
  final double? size;
  final int? maxLines;

  final FontWeight? weight;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context)
          .textTheme
          .bodyMedium
          ?.copyWith(color: color, fontSize: size, fontWeight: weight),
    );
  }
}
