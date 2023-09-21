import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class DropdownField<T> extends StatefulWidget {
  final List<T> items;
  final String labelText;
  final String hintText;
  final bool showSearch;
  final String Function(T item)? itemAsString;
  final void Function(T? item)? onChanged;

  const DropdownField({
    super.key,
    required this.items,
    this.itemAsString,
    required this.labelText,
    required this.hintText,
    this.showSearch = true,
    this.onChanged,
  });

  @override
  State<DropdownField<T>> createState() => _DropdownFieldState<T>();
}

class _DropdownFieldState<T> extends State<DropdownField<T>> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          8,
        ),
        border: Border.all(color: Colors.grey, width: 1),
      ),
      padding: const EdgeInsets.all(4).copyWith(
        top: 4 * 1.5,
      ),
      child: DropdownSearch<T>(
        popupProps: PopupProps.menu(
          showSearchBox: widget.showSearch,
          fit: FlexFit.loose,
          searchFieldProps: TextFieldProps(
            cursorColor: Colors.grey.shade300,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: InputDecoration(hintText: widget.hintText),
          ),
        ),
        itemAsString: widget.itemAsString,
        items: widget.items,
       
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: Theme.of(context).textTheme.bodyMedium,
          dropdownSearchDecoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            suffixIconColor: Colors.grey.shade300,
            labelText: widget.labelText,
            border: InputBorder.none,
            focusColor: Colors.grey.shade300,
            isCollapsed: true,
            suffix: const Icon(Icons.arrow_drop_down),
            suffixIcon: const SizedBox(),
            suffixIconConstraints: BoxConstraints.loose(Size.zero),
            labelStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                  height: 0.35,
                ),
          ),
        ),
        onChanged: widget.onChanged,
        selectedItem: null,
        autoValidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }
}
