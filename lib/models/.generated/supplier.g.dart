// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../supplier.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Supplier _$$_SupplierFromJson(Map<String, dynamic> json) => _$_Supplier(
      supplierId: json['supplierId'] as int?,
      supplierName: json['supplierName'] as String,
      supplierContact: json['supplierContact'] as String?,
      supplierEmail: json['supplierEmail'] as String?,
      supplierAddress: json['supplierAddress'] as String?,
    );

Map<String, dynamic> _$$_SupplierToJson(_$_Supplier instance) =>
    <String, dynamic>{
      'supplierId': instance.supplierId,
      'supplierName': instance.supplierName,
      'supplierContact': instance.supplierContact,
      'supplierEmail': instance.supplierEmail,
      'supplierAddress': instance.supplierAddress,
    };
