import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rich_co_inventory/models/user.dart';
import 'package:rich_co_inventory/providers/user_provider.dart';
import 'package:rich_co_inventory/widgets/texts.dart';

class ListTileCard extends ConsumerWidget {
  const ListTileCard({
    super.key,
    required this.title,
    required this.subTitle,
    required this.deleteIcon,
    this.ontap,
    this.onDelete,
    this.subTitleColor,
    this.titleSize,
    this.boldTitle = false,
    required this.editIcon,
    this.onEdit,
  });
  final String title;
  final String subTitle;
  final Widget deleteIcon;
  final Widget editIcon;
  final Function()? ontap;
  final Function()? onDelete;
  final Function()? onEdit;
  final Color? subTitleColor;
  final double? titleSize;
  final bool boldTitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canEdit = ref.watch(userProvider)?.role == Role.superAdmin;

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
      trailing: SizedBox(
        width: 100,
        child: Visibility(
          visible: canEdit,
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(
                      8,
                    )),
                child: GestureDetector(
                  onTap: onEdit,
                  child: editIcon,
                ),
              ),
              SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(
                      8,
                    )),
                child: GestureDetector(
                  onTap: onDelete,
                  child: deleteIcon,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
