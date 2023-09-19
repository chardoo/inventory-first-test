// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Product _$$_ProductFromJson(Map<String, dynamic> json) => _$_Product(
      productId: json['productId'] as int?,
      productName: json['productName'] as String,
      productDescription: json['productDescription'] as String?,
      price: (json['price'] as num).toDouble(),
      supplierId: json['supplierId'] as int?,
      brandId: json['brandId'] as int?,
    );

Map<String, dynamic> _$$_ProductToJson(_$_Product instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'productName': instance.productName,
      'productDescription': instance.productDescription,
      'price': instance.price,
      'supplierId': instance.supplierId,
      'brandId': instance.brandId,
    };
