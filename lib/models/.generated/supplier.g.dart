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
      purchases: (json['purchases'] as List<dynamic>?)
          ?.map((e) => Purchase.fromJson(e as Map<String, dynamic>))
          .toList(),
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_SupplierToJson(_$_Supplier instance) =>
    <String, dynamic>{
      'supplierId': instance.supplierId,
      'supplierName': instance.supplierName,
      'supplierContact': instance.supplierContact,
      'supplierEmail': instance.supplierEmail,
      'supplierAddress': instance.supplierAddress,
      'purchases': instance.purchases?.map((e) => e.toJson()).toList(),
      'products': instance.products?.map((e) => e.toJson()).toList(),
    };
