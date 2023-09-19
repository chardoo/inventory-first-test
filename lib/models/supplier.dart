import 'package:freezed_annotation/freezed_annotation.dart';

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
  }) = _Supplier;

  factory Supplier.fromJson(Map<String, dynamic> json) => _$SupplierFromJson(json);
}
