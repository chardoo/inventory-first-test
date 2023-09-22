import 'package:freezed_annotation/freezed_annotation.dart';

part '.generated/purchase.freezed.dart';
part '.generated/purchase.g.dart';

@freezed
abstract class Purchase with _$Purchase {
  const factory Purchase({
   required String purchaseId,
   required String productId,
    required DateTime purchaseDate,
    required int quantityPurchased,
    int? supplierId,
    required double cost,
  }) = _Purchase;

  factory Purchase.fromJson(Map<String, dynamic> json) => _$PurchaseFromJson(json);
}
