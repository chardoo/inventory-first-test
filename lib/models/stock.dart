import 'package:freezed_annotation/freezed_annotation.dart';

part '.generated/stock.freezed.dart';
part '.generated/stock.g.dart';

@freezed
abstract class Stock with _$Stock {
  const factory Stock({
    required String stockId,
    required String productId,
    required int currentQuantity,
    required int minimumRequiredQuantity,
  }) = _Stock;

  factory Stock.fromJson(Map<String, dynamic> json) => _$StockFromJson(json);
}
