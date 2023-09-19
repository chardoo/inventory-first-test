import 'package:freezed_annotation/freezed_annotation.dart';

part '.generated/brand.freezed.dart';
part '.generated/brand.g.dart';

@freezed
abstract class Brand with _$Brand {
  const factory Brand({
    String? brandId,
    required String brandName,
    String? brandDescription,
  }) = _Brand;

  factory Brand.fromJson(Map<String, dynamic> json) => _$BrandFromJson(json);
}
