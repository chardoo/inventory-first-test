import 'package:flutter/cupertino.dart';

import '../../models/stock.dart';
import '../inventory/all_inventory.dart';
import '../shared/view_all_items_states.dart';

class StockSuccessState extends SuccessState<List<Stock>> {
  StockSuccessState(super.data);

  @override
  display() {
    return Expanded(
      child: ListView.separated(
          separatorBuilder: (_, i) => const SizedBox(height: 12),
          itemCount: data.length,
          itemBuilder: (_, i) {
            //  return Text("richOCDE");
            final inventory = data[i];
            return StockCard(
              //  date: inventory.purchaseDate,
              stock: inventory,
            );
          }),
    );
  }
}
