import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part '.generated/sales.freezed.dart';
part '.generated/sales.g.dart';

@unfreezed
abstract class Sale with _$Sale {
  factory Sale({
    String? saleId,
    required String productId,
    required int saleDate,
     int? quantitySold,
    required String productName,
    required double productPrice,
    @Default(0) double totalRevenue,
    int? salesmanId,
    List<Sale>? sales,
  }) = _Sale;

  factory Sale.fromJson(Map<String, dynamic> json) => _$SaleFromJson(json);

  factory Sale.generateId(Map<String, dynamic> json) {
    const uuid = Uuid();
    json["saleId"] = uuid.v4();

    return Sale.fromJson(json);
  }
}
