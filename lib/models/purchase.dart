import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rich_co_inventory/models/product.dart';
import 'package:uuid/uuid.dart';

part '.generated/purchase.freezed.dart';
part '.generated/purchase.g.dart';

@freezed
abstract class Purchase with _$Purchase {
  const factory Purchase({
    String? purchaseId,
   required String productId,
      required String productName,
    required int purchaseDate,
    required int quantityPurchased,
    String? supplierId,
    required double cost,
    Product ? product,
  }) = _Purchase;

  factory Purchase.fromJson(Map<String, dynamic> json) => _$PurchaseFromJson(json);



  factory Purchase.generateId(Map<String, dynamic> json) {
    const uuid = Uuid();
    json["purchaseId"] = uuid.v4();
    return Purchase.fromJson(json);
  }

}
