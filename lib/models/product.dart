import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rich_co_inventory/models/purchase.dart';
import 'package:rich_co_inventory/models/sales.dart';
import 'package:rich_co_inventory/models/stock.dart';

part '.generated/product.freezed.dart';
part '.generated/product.g.dart';

@freezed
abstract class Product with _$Product {
  const factory Product({
    String? productId,
    required String productName,
    String? productDescription,
    required double price,
    String? supplierId,
    String? brandId,
    List<Sale> ? sales,
    List<Purchase> ? purchases, 
     List<Stock> ? stocks, 
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
}
