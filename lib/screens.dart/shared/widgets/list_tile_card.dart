import 'package:flutter/material.dart';
import 'package:rich_co_inventory/screens.dart/shared/widgets/texts.dart';

class ListTileCard extends StatelessWidget {
  const ListTileCard({
    super.key,
    required this.title,
    required this.subTitle,
    required this.icon,
    this.ontap,
    this.onIconTap,
    this.subTitleColor,
    this.titleSize,
    this.boldTitle = false,
  });
  final String title;
  final String subTitle;
  final Widget icon;
  final Function()? ontap;
  final Function()? onIconTap;
  final Color? subTitleColor;
  final double? titleSize;
  final bool boldTitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: MyText(
        text: title,
        weight: boldTitle ? FontWeight.bold : FontWeight.normal,
        size: titleSize,
      ),
      onTap: ontap,
      subtitle: MyText(
        text: subTitle,
        color: subTitleColor ?? Colors.blue,
      ),
      trailing: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(
              8,
            )),
        child: GestureDetector(
          onTap: onIconTap,
          child: icon,
        ),
      ),
    );
  }
}
