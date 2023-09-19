// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../purchase.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Purchase _$$_PurchaseFromJson(Map<String, dynamic> json) => _$_Purchase(
      purchaseId: json['purchaseId'] as String,
      productId: json['productId'] as String,
      purchaseDate: DateTime.parse(json['purchaseDate'] as String),
      quantityPurchased: json['quantityPurchased'] as int,
      supplierId: json['supplierId'] as int?,
      totalCost: (json['totalCost'] as num).toDouble(),
    );

Map<String, dynamic> _$$_PurchaseToJson(_$_Purchase instance) =>
    <String, dynamic>{
      'purchaseId': instance.purchaseId,
      'productId': instance.productId,
      'purchaseDate': instance.purchaseDate.toIso8601String(),
      'quantityPurchased': instance.quantityPurchased,
      'supplierId': instance.supplierId,
      'totalCost': instance.totalCost,
    };
