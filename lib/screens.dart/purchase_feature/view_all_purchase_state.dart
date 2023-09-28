

import 'package:flutter/cupertino.dart';

import '../../models/purchase.dart';
import '../shared/view_all_items_states.dart';
import 'all_purchase_page.dart';

class PurchaseSuccessState extends SuccessState<List<Purchase>> {
  PurchaseSuccessState(super.data);

  @override
  display() {
    return Expanded(
        child: ListView.separated(
            separatorBuilder: (_, i) => const SizedBox(height: 12),
            itemCount: data.length,
            itemBuilder: (_, i) {
              final purchase = data[i];
              return PurchaseCard(
                  date:
                      DateTime.fromMillisecondsSinceEpoch(purchase.purchaseDate)
                          .toString(),
                  productName: purchase.productName,
                  quantity: purchase.quantityPurchased,
                  price: purchase.cost.toDouble());
            }));
  }
}