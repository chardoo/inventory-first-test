import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part '.generated/stock.freezed.dart';
part '.generated/stock.g.dart';

@freezed
abstract class Stock with _$Stock {
  const factory Stock({
    String? stockId,
    required String productId,
     String? productName,
       double ? productPrice,
    required int currentQuantity,
    required int minimumRequiredQuantity,
  }) = _Stock;

  factory Stock.fromJson(Map<String, dynamic> json) => _$StockFromJson(json);

  factory Stock.generateId(Map<String, dynamic> json) {
    const uuid = Uuid();
    json["stockId"] = uuid.v4();

    return Stock.fromJson(json);
  }
}
