import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rich_co_inventory/models/product.dart';
import 'package:rich_co_inventory/models/purchase.dart';
import 'package:uuid/uuid.dart';

part '.generated/supplier.freezed.dart';
part '.generated/supplier.g.dart';

@freezed
abstract class Supplier with _$Supplier {
  const factory Supplier({
    String? supplierId,
    required String supplierName,
    String? supplierContact,
    String? supplierEmail,
    String? supplierAddress,
    List<Purchase>? purchases,
    List<Product>? products,
  }) = _Supplier;
  factory Supplier.generateId(Map<String, dynamic> json) {
    const uuid = Uuid();
    json["supplierId"] = uuid.v4();

    return Supplier.fromJson(json);
  }
  factory Supplier.fromJson(Map<String, dynamic> json) =>
      _$SupplierFromJson(json);
}
