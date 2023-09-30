// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Product _$$_ProductFromJson(Map<String, dynamic> json) => _$_Product(
      productId: json['productId'] as String?,
      productName: json['productName'] as String,
      productDescription: json['productDescription'] as String?,
      price: (json['price'] as num).toDouble(),
      supplierId: json['supplierId'] as String?,
      brandId: json['brandId'] as String?,
      expiryDate: json['expiryDate'] as int?,
      sales: (json['sales'] as List<dynamic>?)
          ?.map((e) => Sale.fromJson(e as Map<String, dynamic>))
          .toList(),
      purchases: (json['purchases'] as List<dynamic>?)
          ?.map((e) => Purchase.fromJson(e as Map<String, dynamic>))
          .toList(),
      stocks: (json['stocks'] as List<dynamic>?)
          ?.map((e) => Stock.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_ProductToJson(_$_Product instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'productName': instance.productName,
      'productDescription': instance.productDescription,
      'price': instance.price,
      'supplierId': instance.supplierId,
      'brandId': instance.brandId,
      'expiryDate': instance.expiryDate,
      'sales': instance.sales?.map((e) => e.toJson()).toList(),
      'purchases': instance.purchases?.map((e) => e.toJson()).toList(),
      'stocks': instance.stocks?.map((e) => e.toJson()).toList(),
    };
