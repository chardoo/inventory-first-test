// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../purchase.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Purchase _$$_PurchaseFromJson(Map<String, dynamic> json) => _$_Purchase(
      purchaseId: json['purchaseId'] as String?,
      productId: json['productId'] as String,
      productName: json['productName'] as String,
      purchaseDate: json['purchaseDate'] as int,
      quantityPurchased: json['quantityPurchased'] as int,
      supplierId: json['supplierId'] as String?,
      cost: (json['cost'] as num).toDouble(),
      product: json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_PurchaseToJson(_$_Purchase instance) =>
    <String, dynamic>{
      'purchaseId': instance.purchaseId,
      'productId': instance.productId,
      'productName': instance.productName,
      'purchaseDate': instance.purchaseDate,
      'quantityPurchased': instance.quantityPurchased,
      'supplierId': instance.supplierId,
      'cost': instance.cost,
      'product': instance.product?.toJson(),
    };
