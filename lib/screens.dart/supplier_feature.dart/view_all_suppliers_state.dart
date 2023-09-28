

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/supplier.dart';
import '../shared/view_all_items_states.dart';
import '../shared/widgets/list_tile_card.dart';

class SupplierSuccessState extends SuccessState<List<Supplier>> {
  SupplierSuccessState(super.data);

  @override
  display() {
    return Expanded(
      child: ListView.separated(
        itemBuilder: (_, i) {
          final supplier = data[i];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ListTileCard(
              title: supplier.supplierName,
              boldTitle: true,
              titleSize: 16,
              subTitleColor: Colors.grey,
              subTitle:
                  " \n${supplier.supplierAddress} \n${supplier.supplierContact} | "
                  "${supplier.supplierContact}",
              icon: const Icon(Icons.delete),
            ),
          );
        },
        itemCount: data.length,
        separatorBuilder: (BuildContext context, int index) {
          return const Divider();
        },
      ),
    );
  }
}


