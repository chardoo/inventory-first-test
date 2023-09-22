// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../stock.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Stock _$StockFromJson(Map<String, dynamic> json) {
  return _Stock.fromJson(json);
}

/// @nodoc
mixin _$Stock {
  String? get stockId => throw _privateConstructorUsedError;
  String get productId => throw _privateConstructorUsedError;
  int get currentQuantity => throw _privateConstructorUsedError;
  int get minimumRequiredQuantity => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StockCopyWith<Stock> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StockCopyWith<$Res> {
  factory $StockCopyWith(Stock value, $Res Function(Stock) then) =
      _$StockCopyWithImpl<$Res, Stock>;
  @useResult
  $Res call(
      {String? stockId,
      String productId,
      int currentQuantity,
      int minimumRequiredQuantity});
}

/// @nodoc
class _$StockCopyWithImpl<$Res, $Val extends Stock>
    implements $StockCopyWith<$Res> {
  _$StockCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stockId = freezed,
    Object? productId = null,
    Object? currentQuantity = null,
    Object? minimumRequiredQuantity = null,
  }) {
    return _then(_value.copyWith(
      stockId: freezed == stockId
          ? _value.stockId
          : stockId // ignore: cast_nullable_to_non_nullable
              as String?,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      currentQuantity: null == currentQuantity
          ? _value.currentQuantity
          : currentQuantity // ignore: cast_nullable_to_non_nullable
              as int,
      minimumRequiredQuantity: null == minimumRequiredQuantity
          ? _value.minimumRequiredQuantity
          : minimumRequiredQuantity // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_StockCopyWith<$Res> implements $StockCopyWith<$Res> {
  factory _$$_StockCopyWith(_$_Stock value, $Res Function(_$_Stock) then) =
      __$$_StockCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? stockId,
      String productId,
      int currentQuantity,
      int minimumRequiredQuantity});
}

/// @nodoc
class __$$_StockCopyWithImpl<$Res> extends _$StockCopyWithImpl<$Res, _$_Stock>
    implements _$$_StockCopyWith<$Res> {
  __$$_StockCopyWithImpl(_$_Stock _value, $Res Function(_$_Stock) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stockId = freezed,
    Object? productId = null,
    Object? currentQuantity = null,
    Object? minimumRequiredQuantity = null,
  }) {
    return _then(_$_Stock(
      stockId: freezed == stockId
          ? _value.stockId
          : stockId // ignore: cast_nullable_to_non_nullable
              as String?,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      currentQuantity: null == currentQuantity
          ? _value.currentQuantity
          : currentQuantity // ignore: cast_nullable_to_non_nullable
              as int,
      minimumRequiredQuantity: null == minimumRequiredQuantity
          ? _value.minimumRequiredQuantity
          : minimumRequiredQuantity // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Stock implements _Stock {
  const _$_Stock(
      {this.stockId,
      required this.productId,
      required this.currentQuantity,
      required this.minimumRequiredQuantity});

  factory _$_Stock.fromJson(Map<String, dynamic> json) =>
      _$$_StockFromJson(json);

  @override
  final String? stockId;
  @override
  final String productId;
  @override
  final int currentQuantity;
  @override
  final int minimumRequiredQuantity;

  @override
  String toString() {
    return 'Stock(stockId: $stockId, productId: $productId, currentQuantity: $currentQuantity, minimumRequiredQuantity: $minimumRequiredQuantity)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Stock &&
            (identical(other.stockId, stockId) || other.stockId == stockId) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.currentQuantity, currentQuantity) ||
                other.currentQuantity == currentQuantity) &&
            (identical(
                    other.minimumRequiredQuantity, minimumRequiredQuantity) ||
                other.minimumRequiredQuantity == minimumRequiredQuantity));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, stockId, productId,
      currentQuantity, minimumRequiredQuantity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_StockCopyWith<_$_Stock> get copyWith =>
      __$$_StockCopyWithImpl<_$_Stock>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_StockToJson(
      this,
    );
  }
}

abstract class _Stock implements Stock {
  const factory _Stock(
      {final String? stockId,
      required final String productId,
      required final int currentQuantity,
      required final int minimumRequiredQuantity}) = _$_Stock;

  factory _Stock.fromJson(Map<String, dynamic> json) = _$_Stock.fromJson;

  @override
  String? get stockId;
  @override
  String get productId;
  @override
  int get currentQuantity;
  @override
  int get minimumRequiredQuantity;
  @override
  @JsonKey(ignore: true)
  _$$_StockCopyWith<_$_Stock> get copyWith =>
      throw _privateConstructorUsedError;
}
