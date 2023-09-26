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
  String? get purchaseId => throw _privateConstructorUsedError;
  String get productId => throw _privateConstructorUsedError;
  String get productName => throw _privateConstructorUsedError;
  int get purchaseDate => throw _privateConstructorUsedError;
  int get quantityPurchased => throw _privateConstructorUsedError;
  String? get supplierId => throw _privateConstructorUsedError;
  double get cost => throw _privateConstructorUsedError;
  Product? get product => throw _privateConstructorUsedError;

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
      {String? purchaseId,
      String productId,
      String productName,
      int purchaseDate,
      int quantityPurchased,
      String? supplierId,
      double cost,
      Product? product});

  $ProductCopyWith<$Res>? get product;
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
    Object? purchaseId = freezed,
    Object? productId = null,
    Object? productName = null,
    Object? purchaseDate = null,
    Object? quantityPurchased = null,
    Object? supplierId = freezed,
    Object? cost = null,
    Object? product = freezed,
  }) {
    return _then(_value.copyWith(
      purchaseId: freezed == purchaseId
          ? _value.purchaseId
          : purchaseId // ignore: cast_nullable_to_non_nullable
              as String?,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      productName: null == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String,
      purchaseDate: null == purchaseDate
          ? _value.purchaseDate
          : purchaseDate // ignore: cast_nullable_to_non_nullable
              as int,
      quantityPurchased: null == quantityPurchased
          ? _value.quantityPurchased
          : quantityPurchased // ignore: cast_nullable_to_non_nullable
              as int,
      supplierId: freezed == supplierId
          ? _value.supplierId
          : supplierId // ignore: cast_nullable_to_non_nullable
              as String?,
      cost: null == cost
          ? _value.cost
          : cost // ignore: cast_nullable_to_non_nullable
              as double,
      product: freezed == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as Product?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ProductCopyWith<$Res>? get product {
    if (_value.product == null) {
      return null;
    }

    return $ProductCopyWith<$Res>(_value.product!, (value) {
      return _then(_value.copyWith(product: value) as $Val);
    });
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
      {String? purchaseId,
      String productId,
      String productName,
      int purchaseDate,
      int quantityPurchased,
      String? supplierId,
      double cost,
      Product? product});

  @override
  $ProductCopyWith<$Res>? get product;
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
    Object? purchaseId = freezed,
    Object? productId = null,
    Object? productName = null,
    Object? purchaseDate = null,
    Object? quantityPurchased = null,
    Object? supplierId = freezed,
    Object? cost = null,
    Object? product = freezed,
  }) {
    return _then(_$_Purchase(
      purchaseId: freezed == purchaseId
          ? _value.purchaseId
          : purchaseId // ignore: cast_nullable_to_non_nullable
              as String?,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      productName: null == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String,
      purchaseDate: null == purchaseDate
          ? _value.purchaseDate
          : purchaseDate // ignore: cast_nullable_to_non_nullable
              as int,
      quantityPurchased: null == quantityPurchased
          ? _value.quantityPurchased
          : quantityPurchased // ignore: cast_nullable_to_non_nullable
              as int,
      supplierId: freezed == supplierId
          ? _value.supplierId
          : supplierId // ignore: cast_nullable_to_non_nullable
              as String?,
      cost: null == cost
          ? _value.cost
          : cost // ignore: cast_nullable_to_non_nullable
              as double,
      product: freezed == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as Product?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Purchase implements _Purchase {
  const _$_Purchase(
      {this.purchaseId,
      required this.productId,
      required this.productName,
      required this.purchaseDate,
      required this.quantityPurchased,
      this.supplierId,
      required this.cost,
      this.product});

  factory _$_Purchase.fromJson(Map<String, dynamic> json) =>
      _$$_PurchaseFromJson(json);

  @override
  final String? purchaseId;
  @override
  final String productId;
  @override
  final String productName;
  @override
  final int purchaseDate;
  @override
  final int quantityPurchased;
  @override
  final String? supplierId;
  @override
  final double cost;
  @override
  final Product? product;

  @override
  String toString() {
    return 'Purchase(purchaseId: $purchaseId, productId: $productId, productName: $productName, purchaseDate: $purchaseDate, quantityPurchased: $quantityPurchased, supplierId: $supplierId, cost: $cost, product: $product)';
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
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.purchaseDate, purchaseDate) ||
                other.purchaseDate == purchaseDate) &&
            (identical(other.quantityPurchased, quantityPurchased) ||
                other.quantityPurchased == quantityPurchased) &&
            (identical(other.supplierId, supplierId) ||
                other.supplierId == supplierId) &&
            (identical(other.cost, cost) || other.cost == cost) &&
            (identical(other.product, product) || other.product == product));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, purchaseId, productId,
      productName, purchaseDate, quantityPurchased, supplierId, cost, product);

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
      {final String? purchaseId,
      required final String productId,
      required final String productName,
      required final int purchaseDate,
      required final int quantityPurchased,
      final String? supplierId,
      required final double cost,
      final Product? product}) = _$_Purchase;

  factory _Purchase.fromJson(Map<String, dynamic> json) = _$_Purchase.fromJson;

  @override
  String? get purchaseId;
  @override
  String get productId;
  @override
  String get productName;
  @override
  int get purchaseDate;
  @override
  int get quantityPurchased;
  @override
  String? get supplierId;
  @override
  double get cost;
  @override
  Product? get product;
  @override
  @JsonKey(ignore: true)
  _$$_PurchaseCopyWith<_$_Purchase> get copyWith =>
      throw _privateConstructorUsedError;
}
