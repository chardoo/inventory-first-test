// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../sales.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Sale _$$_SaleFromJson(Map<String, dynamic> json) => _$_Sale(
      saleId: json['saleId'] as String?,
      productId: json['productId'] as String,
      saleDate: json['saleDate'] as int,
      quantitySold: json['quantitySold'] as int?,
      productName: json['productName'] as String,
      productPrice: (json['productPrice'] as num).toDouble(),
      time: json['time'] as String,
      totalRevenue: (json['totalRevenue'] as num?)?.toDouble() ?? 0,
      salesmanId: json['salesmanId'] as int?,
      sales: (json['sales'] as List<dynamic>?)
          ?.map((e) => Sale.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_SaleToJson(_$_Sale instance) => <String, dynamic>{
      'saleId': instance.saleId,
      'productId': instance.productId,
      'saleDate': instance.saleDate,
      'quantitySold': instance.quantitySold,
      'productName': instance.productName,
      'productPrice': instance.productPrice,
      'time': instance.time,
      'totalRevenue': instance.totalRevenue,
      'salesmanId': instance.salesmanId,
      'sales': instance.sales?.map((e) => e.toJson()).toList(),
    };
