

import 'package:flutter/material.dart';

import '../../models/brand.dart';
import '../shared/view_all_items_states.dart';
import '../../widgets/list_tile_card.dart';

class BrandSuccessState extends SuccessState<List<Brand>> {
  BrandSuccessState(super.data);

  @override
  display() {
    return Expanded(
      child: ListView.separated(
        itemBuilder: (_, i) {
          final brand = data[i];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ListTileCard(
              title: brand.brandName,
              boldTitle: true,
              titleSize: 16,
              subTitleColor: Colors.grey,
              subTitle: brand.brandDescription,
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

