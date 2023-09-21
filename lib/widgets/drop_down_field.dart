import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:rich_co_inventory/widgets/shimmer.dart';

class SearchDropDownMenu<T> extends StatelessWidget {
  SearchDropDownMenu(
      {super.key,
      required BuildContext context,
      required this.itemBuilder,
      required this.controller,
      required this.onSelected,
      required this.suggestionsCallback,
      this.onFetchData,
      this.trailing,
      this.label});

  final Widget Function(BuildContext context, T data) itemBuilder;
  final TextEditingController controller;
  final Function(T val) onSelected;
  final Function(String val)? onFetchData;
  final Function(String val) suggestionsCallback;
  final Widget? trailing;
  final String? label;
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      return TypeAheadField<T>(
        textFieldConfiguration: TextFieldConfiguration(
          controller: controller,
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
            fillColor: Colors.grey.shade100,
            filled: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 18),
            suffixIcon: trailing,
            focusedBorder: border,
            labelText: label,
            border: border,
          ),
        ),
        itemBuilder: itemBuilder,
        loadingBuilder: (_) {
          return shimer(context);
        },
        errorBuilder: (_, err) {
          return errorBuilder();
        },
        noItemsFoundBuilder: (_) => shimer(context),
        onSuggestionSelected: (T city) {
          onSelected(city);
        },
        debounceDuration: const Duration(seconds: 1),
        suggestionsCallback: (val) => suggestionsCallback(val),
      );
    });
  }

  OutlineInputBorder border = OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.grey),
    borderRadius: BorderRadius.circular(8),
  );
  Widget errorBuilder() {
    return const Center(child: Text("Try again please"));
  }

  Widget shimer(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return ListView.separated(
      itemCount: 3,
      itemBuilder: (_, i) {
        return ListTile(
            leading: ShimmerLayout(
              width: width * 0.15,
              height: 40,
              shape: BoxShape.circle,
              radius: null,
            ),
            title: ShimmerLayout(height: 15, width: width * 0.6),
            subtitle: ShimmerLayout(height: 15, width: width * 0.3));
      },
      separatorBuilder: (_, i) => const SizedBox(height: 5),
    );
  }
}
