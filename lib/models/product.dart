import 'package:freezed_annotation/freezed_annotation.dart';

part '.generated/product.freezed.dart';
part '.generated/product.g.dart';

@freezed
abstract class Product with _$Product {
  const factory Product({
    int? productId,
    required String productName,
    String? productDescription,
    required double price,
    int? supplierId,
    int? brandId,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
}
