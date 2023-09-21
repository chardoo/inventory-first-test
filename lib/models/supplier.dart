import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rich_co_inventory/models/product.dart';
import 'package:rich_co_inventory/models/purchase.dart';

part '.generated/supplier.freezed.dart';
part '.generated/supplier.g.dart';

@freezed
abstract class Supplier with _$Supplier {
  const factory Supplier({
    int? supplierId,
    required String supplierName,
    String? supplierContact,
    String? supplierEmail,
    String? supplierAddress,
     List<Purchase> ? purchases, 
      List<Product> ? products, 
  }) = _Supplier;

  factory Supplier.fromJson(Map<String, dynamic> json) => _$SupplierFromJson(json);
}


