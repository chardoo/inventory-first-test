import 'package:freezed_annotation/freezed_annotation.dart';

part '.generated/brand.freezed.dart';
part '.generated/brand.g.dart';

@Freezed(unionValueCase: FreezedUnionCase.screamingSnake)
abstract class Brand with _$Brand {
  const factory Brand({
    @JsonKey(toJson: Converter.toLowerCase) required String brandName,
    required String brandDescription,
  }) = _Brand;

  factory Brand.fromJson(Map<String, dynamic> json) => _$BrandFromJson(json);
}

class Converter {
  static String toLowerCase(String i) {
    return i.toLowerCase();
  }
}
