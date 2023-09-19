// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../sales_man.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Salesman _$SalesmanFromJson(Map<String, dynamic> json) {
  return _Salesman.fromJson(json);
}

/// @nodoc
mixin _$Salesman {
  int? get salesmanId => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String? get lastName => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get contactNumber => throw _privateConstructorUsedError;
  DateTime? get hireDate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SalesmanCopyWith<Salesman> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SalesmanCopyWith<$Res> {
  factory $SalesmanCopyWith(Salesman value, $Res Function(Salesman) then) =
      _$SalesmanCopyWithImpl<$Res, Salesman>;
  @useResult
  $Res call(
      {int? salesmanId,
      String firstName,
      String? lastName,
      String? email,
      String? contactNumber,
      DateTime? hireDate});
}

/// @nodoc
class _$SalesmanCopyWithImpl<$Res, $Val extends Salesman>
    implements $SalesmanCopyWith<$Res> {
  _$SalesmanCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? salesmanId = freezed,
    Object? firstName = null,
    Object? lastName = freezed,
    Object? email = freezed,
    Object? contactNumber = freezed,
    Object? hireDate = freezed,
  }) {
    return _then(_value.copyWith(
      salesmanId: freezed == salesmanId
          ? _value.salesmanId
          : salesmanId // ignore: cast_nullable_to_non_nullable
              as int?,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      contactNumber: freezed == contactNumber
          ? _value.contactNumber
          : contactNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      hireDate: freezed == hireDate
          ? _value.hireDate
          : hireDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SalesmanCopyWith<$Res> implements $SalesmanCopyWith<$Res> {
  factory _$$_SalesmanCopyWith(
          _$_Salesman value, $Res Function(_$_Salesman) then) =
      __$$_SalesmanCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? salesmanId,
      String firstName,
      String? lastName,
      String? email,
      String? contactNumber,
      DateTime? hireDate});
}

/// @nodoc
class __$$_SalesmanCopyWithImpl<$Res>
    extends _$SalesmanCopyWithImpl<$Res, _$_Salesman>
    implements _$$_SalesmanCopyWith<$Res> {
  __$$_SalesmanCopyWithImpl(
      _$_Salesman _value, $Res Function(_$_Salesman) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? salesmanId = freezed,
    Object? firstName = null,
    Object? lastName = freezed,
    Object? email = freezed,
    Object? contactNumber = freezed,
    Object? hireDate = freezed,
  }) {
    return _then(_$_Salesman(
      salesmanId: freezed == salesmanId
          ? _value.salesmanId
          : salesmanId // ignore: cast_nullable_to_non_nullable
              as int?,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      contactNumber: freezed == contactNumber
          ? _value.contactNumber
          : contactNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      hireDate: freezed == hireDate
          ? _value.hireDate
          : hireDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Salesman implements _Salesman {
  const _$_Salesman(
      {this.salesmanId,
      required this.firstName,
      this.lastName,
      this.email,
      this.contactNumber,
      this.hireDate});

  factory _$_Salesman.fromJson(Map<String, dynamic> json) =>
      _$$_SalesmanFromJson(json);

  @override
  final int? salesmanId;
  @override
  final String firstName;
  @override
  final String? lastName;
  @override
  final String? email;
  @override
  final String? contactNumber;
  @override
  final DateTime? hireDate;

  @override
  String toString() {
    return 'Salesman(salesmanId: $salesmanId, firstName: $firstName, lastName: $lastName, email: $email, contactNumber: $contactNumber, hireDate: $hireDate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Salesman &&
            (identical(other.salesmanId, salesmanId) ||
                other.salesmanId == salesmanId) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.contactNumber, contactNumber) ||
                other.contactNumber == contactNumber) &&
            (identical(other.hireDate, hireDate) ||
                other.hireDate == hireDate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, salesmanId, firstName, lastName,
      email, contactNumber, hireDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SalesmanCopyWith<_$_Salesman> get copyWith =>
      __$$_SalesmanCopyWithImpl<_$_Salesman>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SalesmanToJson(
      this,
    );
  }
}

abstract class _Salesman implements Salesman {
  const factory _Salesman(
      {final int? salesmanId,
      required final String firstName,
      final String? lastName,
      final String? email,
      final String? contactNumber,
      final DateTime? hireDate}) = _$_Salesman;

  factory _Salesman.fromJson(Map<String, dynamic> json) = _$_Salesman.fromJson;

  @override
  int? get salesmanId;
  @override
  String get firstName;
  @override
  String? get lastName;
  @override
  String? get email;
  @override
  String? get contactNumber;
  @override
  DateTime? get hireDate;
  @override
  @JsonKey(ignore: true)
  _$$_SalesmanCopyWith<_$_Salesman> get copyWith =>
      throw _privateConstructorUsedError;
}
