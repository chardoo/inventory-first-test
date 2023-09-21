// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../brand.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Brand _$$_BrandFromJson(Map<String, dynamic> json) => _$_Brand(
      brandName: json['brandName'] as String,
      brandDescription: json['brandDescription'] as String,
      product: (json['product'] as List<dynamic>?)
          ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_BrandToJson(_$_Brand instance) => <String, dynamic>{
      'brandName': Converter.toLowerCase(instance.brandName),
      'brandDescription': instance.brandDescription,
      'product': instance.product?.map((e) => e.toJson()).toList(),
    };
