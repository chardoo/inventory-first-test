// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../sales.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Sale _$SaleFromJson(Map<String, dynamic> json) {
  return _Sale.fromJson(json);
}

/// @nodoc
mixin _$Sale {
  String get saleId => throw _privateConstructorUsedError;
  String get productId => throw _privateConstructorUsedError;
  int get saleDate => throw _privateConstructorUsedError;
  int get quantitySold => throw _privateConstructorUsedError;
  double get totalRevenue => throw _privateConstructorUsedError;
  int? get salesmanId => throw _privateConstructorUsedError;
  List<Sale>? get sales => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SaleCopyWith<Sale> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SaleCopyWith<$Res> {
  factory $SaleCopyWith(Sale value, $Res Function(Sale) then) =
      _$SaleCopyWithImpl<$Res, Sale>;
  @useResult
  $Res call(
      {String saleId,
      String productId,
      int saleDate,
      int quantitySold,
      double totalRevenue,
      int? salesmanId,
      List<Sale>? sales});
}

/// @nodoc
class _$SaleCopyWithImpl<$Res, $Val extends Sale>
    implements $SaleCopyWith<$Res> {
  _$SaleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? saleId = null,
    Object? productId = null,
    Object? saleDate = null,
    Object? quantitySold = null,
    Object? totalRevenue = null,
    Object? salesmanId = freezed,
    Object? sales = freezed,
  }) {
    return _then(_value.copyWith(
      saleId: null == saleId
          ? _value.saleId
          : saleId // ignore: cast_nullable_to_non_nullable
              as String,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      saleDate: null == saleDate
          ? _value.saleDate
          : saleDate // ignore: cast_nullable_to_non_nullable
              as int,
      quantitySold: null == quantitySold
          ? _value.quantitySold
          : quantitySold // ignore: cast_nullable_to_non_nullable
              as int,
      totalRevenue: null == totalRevenue
          ? _value.totalRevenue
          : totalRevenue // ignore: cast_nullable_to_non_nullable
              as double,
      salesmanId: freezed == salesmanId
          ? _value.salesmanId
          : salesmanId // ignore: cast_nullable_to_non_nullable
              as int?,
      sales: freezed == sales
          ? _value.sales
          : sales // ignore: cast_nullable_to_non_nullable
              as List<Sale>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SaleCopyWith<$Res> implements $SaleCopyWith<$Res> {
  factory _$$_SaleCopyWith(_$_Sale value, $Res Function(_$_Sale) then) =
      __$$_SaleCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String saleId,
      String productId,
      int saleDate,
      int quantitySold,
      double totalRevenue,
      int? salesmanId,
      List<Sale>? sales});
}

/// @nodoc
class __$$_SaleCopyWithImpl<$Res> extends _$SaleCopyWithImpl<$Res, _$_Sale>
    implements _$$_SaleCopyWith<$Res> {
  __$$_SaleCopyWithImpl(_$_Sale _value, $Res Function(_$_Sale) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? saleId = null,
    Object? productId = null,
    Object? saleDate = null,
    Object? quantitySold = null,
    Object? totalRevenue = null,
    Object? salesmanId = freezed,
    Object? sales = freezed,
  }) {
    return _then(_$_Sale(
      saleId: null == saleId
          ? _value.saleId
          : saleId // ignore: cast_nullable_to_non_nullable
              as String,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      saleDate: null == saleDate
          ? _value.saleDate
          : saleDate // ignore: cast_nullable_to_non_nullable
              as int,
      quantitySold: null == quantitySold
          ? _value.quantitySold
          : quantitySold // ignore: cast_nullable_to_non_nullable
              as int,
      totalRevenue: null == totalRevenue
          ? _value.totalRevenue
          : totalRevenue // ignore: cast_nullable_to_non_nullable
              as double,
      salesmanId: freezed == salesmanId
          ? _value.salesmanId
          : salesmanId // ignore: cast_nullable_to_non_nullable
              as int?,
      sales: freezed == sales
          ? _value._sales
          : sales // ignore: cast_nullable_to_non_nullable
              as List<Sale>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Sale implements _Sale {
  const _$_Sale(
      {required this.saleId,
      required this.productId,
      required this.saleDate,
      required this.quantitySold,
      required this.totalRevenue,
      this.salesmanId,
      final List<Sale>? sales})
      : _sales = sales;

  factory _$_Sale.fromJson(Map<String, dynamic> json) => _$$_SaleFromJson(json);

  @override
  final String saleId;
  @override
  final String productId;
  @override
  final int saleDate;
  @override
  final int quantitySold;
  @override
  final double totalRevenue;
  @override
  final int? salesmanId;
  final List<Sale>? _sales;
  @override
  List<Sale>? get sales {
    final value = _sales;
    if (value == null) return null;
    if (_sales is EqualUnmodifiableListView) return _sales;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Sale(saleId: $saleId, productId: $productId, saleDate: $saleDate, quantitySold: $quantitySold, totalRevenue: $totalRevenue, salesmanId: $salesmanId, sales: $sales)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Sale &&
            (identical(other.saleId, saleId) || other.saleId == saleId) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.saleDate, saleDate) ||
                other.saleDate == saleDate) &&
            (identical(other.quantitySold, quantitySold) ||
                other.quantitySold == quantitySold) &&
            (identical(other.totalRevenue, totalRevenue) ||
                other.totalRevenue == totalRevenue) &&
            (identical(other.salesmanId, salesmanId) ||
                other.salesmanId == salesmanId) &&
            const DeepCollectionEquality().equals(other._sales, _sales));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      saleId,
      productId,
      saleDate,
      quantitySold,
      totalRevenue,
      salesmanId,
      const DeepCollectionEquality().hash(_sales));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SaleCopyWith<_$_Sale> get copyWith =>
      __$$_SaleCopyWithImpl<_$_Sale>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SaleToJson(
      this,
    );
  }
}

abstract class _Sale implements Sale {
  const factory _Sale(
      {required final String saleId,
      required final String productId,
      required final int saleDate,
      required final int quantitySold,
      required final double totalRevenue,
      final int? salesmanId,
      final List<Sale>? sales}) = _$_Sale;

  factory _Sale.fromJson(Map<String, dynamic> json) = _$_Sale.fromJson;

  @override
  String get saleId;
  @override
  String get productId;
  @override
  int get saleDate;
  @override
  int get quantitySold;
  @override
  double get totalRevenue;
  @override
  int? get salesmanId;
  @override
  List<Sale>? get sales;
  @override
  @JsonKey(ignore: true)
  _$$_SaleCopyWith<_$_Sale> get copyWith => throw _privateConstructorUsedError;
}
