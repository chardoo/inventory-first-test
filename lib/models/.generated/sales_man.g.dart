// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../sales_man.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Salesman _$$_SalesmanFromJson(Map<String, dynamic> json) => _$_Salesman(
      salesmanId: json['salesmanId'] as int?,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
      contactNumber: json['contactNumber'] as String?,
      time: json['time'] as String,
      hireDate: json['hireDate'] == null
          ? null
          : DateTime.parse(json['hireDate'] as String),
    );

Map<String, dynamic> _$$_SalesmanToJson(_$_Salesman instance) =>
    <String, dynamic>{
      'salesmanId': instance.salesmanId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'contactNumber': instance.contactNumber,
      'time': instance.time,
      'hireDate': instance.hireDate?.toIso8601String(),
    };
