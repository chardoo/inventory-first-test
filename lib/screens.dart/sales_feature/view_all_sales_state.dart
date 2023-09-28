


import 'package:flutter/material.dart';

import '../../models/sales.dart';
import '../shared/view_all_items_states.dart';
import '../shared/widgets/list_tile_card.dart';

class SalesSuccessState extends SuccessState<List<Sale>> {
  SalesSuccessState(super.data);

  @override
  display() {
    print(data);
    return Expanded(
      child: ListView.separated(
        itemBuilder: (_, i) {
          final sale = data[i];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ListTileCard(
              title: sale.productName,
              subTitle: "View detail",
              icon: Icon(Icons.delete),
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

