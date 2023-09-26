// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../sales.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Sale _$$_SaleFromJson(Map<String, dynamic> json) => _$_Sale(
      saleId: json['saleId'] as String?,
      productId: json['productId'] as String,
      saleDate: DateTime.parse(json['saleDate'] as String),
      quantitySold: json['quantitySold'] as int? ?? 0,
      productName: json['productName'] as String,
      productPrice: (json['productPrice'] as num).toDouble(),
      totalRevenue: (json['totalRevenue'] as num?)?.toDouble() ?? 0,
      salesmanId: json['salesmanId'] as int?,
      sales: (json['sales'] as List<dynamic>?)
          ?.map((e) => Sale.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_SaleToJson(_$_Sale instance) => <String, dynamic>{
      'saleId': instance.saleId,
      'productId': instance.productId,
      'saleDate': instance.saleDate.toIso8601String(),
      'quantitySold': instance.quantitySold,
      'productName': instance.productName,
      'productPrice': instance.productPrice,
      'totalRevenue': instance.totalRevenue,
      'salesmanId': instance.salesmanId,
      'sales': instance.sales?.map((e) => e.toJson()).toList(),
    };
