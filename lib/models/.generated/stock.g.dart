// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../stock.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Stock _$$_StockFromJson(Map<String, dynamic> json) => _$_Stock(
      stockId: json['stockId'] as String,
      productId: json['productId'] as String,
      currentQuantity: json['currentQuantity'] as int,
      minimumRequiredQuantity: json['minimumRequiredQuantity'] as int,
    );

Map<String, dynamic> _$$_StockToJson(_$_Stock instance) => <String, dynamic>{
      'stockId': instance.stockId,
      'productId': instance.productId,
      'currentQuantity': instance.currentQuantity,
      'minimumRequiredQuantity': instance.minimumRequiredQuantity,
    };
