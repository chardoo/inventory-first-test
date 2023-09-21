// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../supplier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Supplier _$SupplierFromJson(Map<String, dynamic> json) {
  return _Supplier.fromJson(json);
}

/// @nodoc
mixin _$Supplier {
  String? get supplierId => throw _privateConstructorUsedError;
  String get supplierName => throw _privateConstructorUsedError;
  String? get supplierContact => throw _privateConstructorUsedError;
  String? get supplierEmail => throw _privateConstructorUsedError;
  String? get supplierAddress => throw _privateConstructorUsedError;
  List<Purchase>? get purchases => throw _privateConstructorUsedError;
  List<Product>? get products => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SupplierCopyWith<Supplier> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SupplierCopyWith<$Res> {
  factory $SupplierCopyWith(Supplier value, $Res Function(Supplier) then) =
      _$SupplierCopyWithImpl<$Res, Supplier>;
  @useResult
  $Res call(
      {String? supplierId,
      String supplierName,
      String? supplierContact,
      String? supplierEmail,
      String? supplierAddress,
      List<Purchase>? purchases,
      List<Product>? products});
}

/// @nodoc
class _$SupplierCopyWithImpl<$Res, $Val extends Supplier>
    implements $SupplierCopyWith<$Res> {
  _$SupplierCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? supplierId = freezed,
    Object? supplierName = null,
    Object? supplierContact = freezed,
    Object? supplierEmail = freezed,
    Object? supplierAddress = freezed,
    Object? purchases = freezed,
    Object? products = freezed,
  }) {
    return _then(_value.copyWith(
      supplierId: freezed == supplierId
          ? _value.supplierId
          : supplierId // ignore: cast_nullable_to_non_nullable
              as String?,
      supplierName: null == supplierName
          ? _value.supplierName
          : supplierName // ignore: cast_nullable_to_non_nullable
              as String,
      supplierContact: freezed == supplierContact
          ? _value.supplierContact
          : supplierContact // ignore: cast_nullable_to_non_nullable
              as String?,
      supplierEmail: freezed == supplierEmail
          ? _value.supplierEmail
          : supplierEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      supplierAddress: freezed == supplierAddress
          ? _value.supplierAddress
          : supplierAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      purchases: freezed == purchases
          ? _value.purchases
          : purchases // ignore: cast_nullable_to_non_nullable
              as List<Purchase>?,
      products: freezed == products
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<Product>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SupplierCopyWith<$Res> implements $SupplierCopyWith<$Res> {
  factory _$$_SupplierCopyWith(
          _$_Supplier value, $Res Function(_$_Supplier) then) =
      __$$_SupplierCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? supplierId,
      String supplierName,
      String? supplierContact,
      String? supplierEmail,
      String? supplierAddress,
      List<Purchase>? purchases,
      List<Product>? products});
}

/// @nodoc
class __$$_SupplierCopyWithImpl<$Res>
    extends _$SupplierCopyWithImpl<$Res, _$_Supplier>
    implements _$$_SupplierCopyWith<$Res> {
  __$$_SupplierCopyWithImpl(
      _$_Supplier _value, $Res Function(_$_Supplier) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? supplierId = freezed,
    Object? supplierName = null,
    Object? supplierContact = freezed,
    Object? supplierEmail = freezed,
    Object? supplierAddress = freezed,
    Object? purchases = freezed,
    Object? products = freezed,
  }) {
    return _then(_$_Supplier(
      supplierId: freezed == supplierId
          ? _value.supplierId
          : supplierId // ignore: cast_nullable_to_non_nullable
              as String?,
      supplierName: null == supplierName
          ? _value.supplierName
          : supplierName // ignore: cast_nullable_to_non_nullable
              as String,
      supplierContact: freezed == supplierContact
          ? _value.supplierContact
          : supplierContact // ignore: cast_nullable_to_non_nullable
              as String?,
      supplierEmail: freezed == supplierEmail
          ? _value.supplierEmail
          : supplierEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      supplierAddress: freezed == supplierAddress
          ? _value.supplierAddress
          : supplierAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      purchases: freezed == purchases
          ? _value._purchases
          : purchases // ignore: cast_nullable_to_non_nullable
              as List<Purchase>?,
      products: freezed == products
          ? _value._products
          : products // ignore: cast_nullable_to_non_nullable
              as List<Product>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Supplier implements _Supplier {
  const _$_Supplier(
      {this.supplierId,
      required this.supplierName,
      this.supplierContact,
      this.supplierEmail,
      this.supplierAddress,
      final List<Purchase>? purchases,
      final List<Product>? products})
      : _purchases = purchases,
        _products = products;

  factory _$_Supplier.fromJson(Map<String, dynamic> json) =>
      _$$_SupplierFromJson(json);

  @override
  final String? supplierId;
  @override
  final String supplierName;
  @override
  final String? supplierContact;
  @override
  final String? supplierEmail;
  @override
  final String? supplierAddress;
  final List<Purchase>? _purchases;
  @override
  List<Purchase>? get purchases {
    final value = _purchases;
    if (value == null) return null;
    if (_purchases is EqualUnmodifiableListView) return _purchases;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<Product>? _products;
  @override
  List<Product>? get products {
    final value = _products;
    if (value == null) return null;
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Supplier(supplierId: $supplierId, supplierName: $supplierName, supplierContact: $supplierContact, supplierEmail: $supplierEmail, supplierAddress: $supplierAddress, purchases: $purchases, products: $products)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Supplier &&
            (identical(other.supplierId, supplierId) ||
                other.supplierId == supplierId) &&
            (identical(other.supplierName, supplierName) ||
                other.supplierName == supplierName) &&
            (identical(other.supplierContact, supplierContact) ||
                other.supplierContact == supplierContact) &&
            (identical(other.supplierEmail, supplierEmail) ||
                other.supplierEmail == supplierEmail) &&
            (identical(other.supplierAddress, supplierAddress) ||
                other.supplierAddress == supplierAddress) &&
            const DeepCollectionEquality()
                .equals(other._purchases, _purchases) &&
            const DeepCollectionEquality().equals(other._products, _products));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      supplierId,
      supplierName,
      supplierContact,
      supplierEmail,
      supplierAddress,
      const DeepCollectionEquality().hash(_purchases),
      const DeepCollectionEquality().hash(_products));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SupplierCopyWith<_$_Supplier> get copyWith =>
      __$$_SupplierCopyWithImpl<_$_Supplier>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SupplierToJson(
      this,
    );
  }
}

abstract class _Supplier implements Supplier {
  const factory _Supplier(
      {final String? supplierId,
      required final String supplierName,
      final String? supplierContact,
      final String? supplierEmail,
      final String? supplierAddress,
      final List<Purchase>? purchases,
      final List<Product>? products}) = _$_Supplier;

  factory _Supplier.fromJson(Map<String, dynamic> json) = _$_Supplier.fromJson;

  @override
  String? get supplierId;
  @override
  String get supplierName;
  @override
  String? get supplierContact;
  @override
  String? get supplierEmail;
  @override
  String? get supplierAddress;
  @override
  List<Purchase>? get purchases;
  @override
  List<Product>? get products;
  @override
  @JsonKey(ignore: true)
  _$$_SupplierCopyWith<_$_Supplier> get copyWith =>
      throw _privateConstructorUsedError;
}
