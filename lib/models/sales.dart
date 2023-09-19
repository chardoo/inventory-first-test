import 'package:freezed_annotation/freezed_annotation.dart';

part '.generated/sales.freezed.dart';
part '.generated/sales.g.dart';

@freezed
abstract class Sale with _$Sale {
  const factory Sale({
    required String saleId,
    required String productId,
    required DateTime saleDate,
    required int quantitySold,
    required double totalRevenue,
    int? salesmanId,
  }) = _Sale;

  factory Sale.fromJson(Map<String, dynamic> json) => _$SaleFromJson(json);
}
