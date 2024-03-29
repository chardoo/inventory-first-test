import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rich_co_inventory/models/product.dart';
import 'package:uuid/uuid.dart';

part '.generated/brand.freezed.dart';
part '.generated/brand.g.dart';

@Freezed(unionValueCase: FreezedUnionCase.screamingSnake)
abstract class Brand with _$Brand {
  const factory Brand({
    String? brandId,
    @JsonKey(toJson: Converter.toLowerCase) required String brandName,
    required String brandDescription,
    List<Product>? product,
  }) = _Brand;
  factory Brand.generateId(Map<String, dynamic> json) {
    const uuid = Uuid();
    json["brandId"] = uuid.v4();

    return Brand.fromJson(json);
  }
  factory Brand.fromJson(Map<String, dynamic> json) => _$BrandFromJson(json);
}

class Converter {
  static String toLowerCase(String i) {
    return i.toLowerCase();
  }

  static produceSearchList(String name) {
    String val = "";
    List<String> result = [];
    for (var s in name.split("")) {
      val = val + s;
      result.add(s);
    }

    return result;
  }
}
