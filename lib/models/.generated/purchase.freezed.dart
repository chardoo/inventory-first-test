// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../purchase.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Purchase _$PurchaseFromJson(Map<String, dynamic> json) {
  return _Purchase.fromJson(json);
}

/// @nodoc
mixin _$Purchase {
  String get purchaseId => throw _privateConstructorUsedError;
  String get productId => throw _privateConstructorUsedError;
  DateTime get purchaseDate => throw _privateConstructorUsedError;
  int get quantityPurchased => throw _privateConstructorUsedError;
  int? get supplierId => throw _privateConstructorUsedError;
  double get totalCost => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PurchaseCopyWith<Purchase> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PurchaseCopyWith<$Res> {
  factory $PurchaseCopyWith(Purchase value, $Res Function(Purchase) then) =
      _$PurchaseCopyWithImpl<$Res, Purchase>;
  @useResult
  $Res call(
      {String purchaseId,
      String productId,
      DateTime purchaseDate,
      int quantityPurchased,
      int? supplierId,
      double totalCost});
}

/// @nodoc
class _$PurchaseCopyWithImpl<$Res, $Val extends Purchase>
    implements $PurchaseCopyWith<$Res> {
  _$PurchaseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? purchaseId = null,
    Object? productId = null,
    Object? purchaseDate = null,
    Object? quantityPurchased = null,
    Object? supplierId = freezed,
    Object? totalCost = null,
  }) {
    return _then(_value.copyWith(
      purchaseId: null == purchaseId
          ? _value.purchaseId
          : purchaseId // ignore: cast_nullable_to_non_nullable
              as String,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      purchaseDate: null == purchaseDate
          ? _value.purchaseDate
          : purchaseDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      quantityPurchased: null == quantityPurchased
          ? _value.quantityPurchased
          : quantityPurchased // ignore: cast_nullable_to_non_nullable
              as int,
      supplierId: freezed == supplierId
          ? _value.supplierId
          : supplierId // ignore: cast_nullable_to_non_nullable
              as int?,
      totalCost: null == totalCost
          ? _value.totalCost
          : totalCost // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PurchaseCopyWith<$Res> implements $PurchaseCopyWith<$Res> {
  factory _$$_PurchaseCopyWith(
          _$_Purchase value, $Res Function(_$_Purchase) then) =
      __$$_PurchaseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String purchaseId,
      String productId,
      DateTime purchaseDate,
      int quantityPurchased,
      int? supplierId,
      double totalCost});
}

/// @nodoc
class __$$_PurchaseCopyWithImpl<$Res>
    extends _$PurchaseCopyWithImpl<$Res, _$_Purchase>
    implements _$$_PurchaseCopyWith<$Res> {
  __$$_PurchaseCopyWithImpl(
      _$_Purchase _value, $Res Function(_$_Purchase) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? purchaseId = null,
    Object? productId = null,
    Object? purchaseDate = null,
    Object? quantityPurchased = null,
    Object? supplierId = freezed,
    Object? totalCost = null,
  }) {
    return _then(_$_Purchase(
      purchaseId: null == purchaseId
          ? _value.purchaseId
          : purchaseId // ignore: cast_nullable_to_non_nullable
              as String,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      purchaseDate: null == purchaseDate
          ? _value.purchaseDate
          : purchaseDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      quantityPurchased: null == quantityPurchased
          ? _value.quantityPurchased
          : quantityPurchased // ignore: cast_nullable_to_non_nullable
              as int,
      supplierId: freezed == supplierId
          ? _value.supplierId
          : supplierId // ignore: cast_nullable_to_non_nullable
              as int?,
      totalCost: null == totalCost
          ? _value.totalCost
          : totalCost // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Purchase implements _Purchase {
  const _$_Purchase(
      {required this.purchaseId,
      required this.productId,
      required this.purchaseDate,
      required this.quantityPurchased,
      this.supplierId,
      required this.totalCost});

  factory _$_Purchase.fromJson(Map<String, dynamic> json) =>
      _$$_PurchaseFromJson(json);

  @override
  final String purchaseId;
  @override
  final String productId;
  @override
  final DateTime purchaseDate;
  @override
  final int quantityPurchased;
  @override
  final int? supplierId;
  @override
  final double totalCost;

  @override
  String toString() {
    return 'Purchase(purchaseId: $purchaseId, productId: $productId, purchaseDate: $purchaseDate, quantityPurchased: $quantityPurchased, supplierId: $supplierId, totalCost: $totalCost)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Purchase &&
            (identical(other.purchaseId, purchaseId) ||
                other.purchaseId == purchaseId) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.purchaseDate, purchaseDate) ||
                other.purchaseDate == purchaseDate) &&
            (identical(other.quantityPurchased, quantityPurchased) ||
                other.quantityPurchased == quantityPurchased) &&
            (identical(other.supplierId, supplierId) ||
                other.supplierId == supplierId) &&
            (identical(other.totalCost, totalCost) ||
                other.totalCost == totalCost));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, purchaseId, productId,
      purchaseDate, quantityPurchased, supplierId, totalCost);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PurchaseCopyWith<_$_Purchase> get copyWith =>
      __$$_PurchaseCopyWithImpl<_$_Purchase>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PurchaseToJson(
      this,
    );
  }
}

abstract class _Purchase implements Purchase {
  const factory _Purchase(
      {required final String purchaseId,
      required final String productId,
      required final DateTime purchaseDate,
      required final int quantityPurchased,
      final int? supplierId,
      required final double totalCost}) = _$_Purchase;

  factory _Purchase.fromJson(Map<String, dynamic> json) = _$_Purchase.fromJson;

  @override
  String get purchaseId;
  @override
  String get productId;
  @override
  DateTime get purchaseDate;
  @override
  int get quantityPurchased;
  @override
  int? get supplierId;
  @override
  double get totalCost;
  @override
  @JsonKey(ignore: true)
  _$$_PurchaseCopyWith<_$_Purchase> get copyWith =>
      throw _privateConstructorUsedError;
}
