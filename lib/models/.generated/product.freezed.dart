// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Product _$ProductFromJson(Map<String, dynamic> json) {
  return _Product.fromJson(json);
}

/// @nodoc
mixin _$Product {
  int? get productId => throw _privateConstructorUsedError;
  String get productName => throw _privateConstructorUsedError;
  String? get productDescription => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  int? get supplierId => throw _privateConstructorUsedError;
  int? get brandId => throw _privateConstructorUsedError;
  List<Sale>? get sales => throw _privateConstructorUsedError;
  List<Purchase>? get purchases => throw _privateConstructorUsedError;
  List<Stock>? get stocks => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductCopyWith<Product> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductCopyWith<$Res> {
  factory $ProductCopyWith(Product value, $Res Function(Product) then) =
      _$ProductCopyWithImpl<$Res, Product>;
  @useResult
  $Res call(
      {int? productId,
      String productName,
      String? productDescription,
      double price,
      int? supplierId,
      int? brandId,
      List<Sale>? sales,
      List<Purchase>? purchases,
      List<Stock>? stocks});
}

/// @nodoc
class _$ProductCopyWithImpl<$Res, $Val extends Product>
    implements $ProductCopyWith<$Res> {
  _$ProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = freezed,
    Object? productName = null,
    Object? productDescription = freezed,
    Object? price = null,
    Object? supplierId = freezed,
    Object? brandId = freezed,
    Object? sales = freezed,
    Object? purchases = freezed,
    Object? stocks = freezed,
  }) {
    return _then(_value.copyWith(
      productId: freezed == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int?,
      productName: null == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String,
      productDescription: freezed == productDescription
          ? _value.productDescription
          : productDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      supplierId: freezed == supplierId
          ? _value.supplierId
          : supplierId // ignore: cast_nullable_to_non_nullable
              as int?,
      brandId: freezed == brandId
          ? _value.brandId
          : brandId // ignore: cast_nullable_to_non_nullable
              as int?,
      sales: freezed == sales
          ? _value.sales
          : sales // ignore: cast_nullable_to_non_nullable
              as List<Sale>?,
      purchases: freezed == purchases
          ? _value.purchases
          : purchases // ignore: cast_nullable_to_non_nullable
              as List<Purchase>?,
      stocks: freezed == stocks
          ? _value.stocks
          : stocks // ignore: cast_nullable_to_non_nullable
              as List<Stock>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ProductCopyWith<$Res> implements $ProductCopyWith<$Res> {
  factory _$$_ProductCopyWith(
          _$_Product value, $Res Function(_$_Product) then) =
      __$$_ProductCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? productId,
      String productName,
      String? productDescription,
      double price,
      int? supplierId,
      int? brandId,
      List<Sale>? sales,
      List<Purchase>? purchases,
      List<Stock>? stocks});
}

/// @nodoc
class __$$_ProductCopyWithImpl<$Res>
    extends _$ProductCopyWithImpl<$Res, _$_Product>
    implements _$$_ProductCopyWith<$Res> {
  __$$_ProductCopyWithImpl(_$_Product _value, $Res Function(_$_Product) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = freezed,
    Object? productName = null,
    Object? productDescription = freezed,
    Object? price = null,
    Object? supplierId = freezed,
    Object? brandId = freezed,
    Object? sales = freezed,
    Object? purchases = freezed,
    Object? stocks = freezed,
  }) {
    return _then(_$_Product(
      productId: freezed == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int?,
      productName: null == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String,
      productDescription: freezed == productDescription
          ? _value.productDescription
          : productDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      supplierId: freezed == supplierId
          ? _value.supplierId
          : supplierId // ignore: cast_nullable_to_non_nullable
              as int?,
      brandId: freezed == brandId
          ? _value.brandId
          : brandId // ignore: cast_nullable_to_non_nullable
              as int?,
      sales: freezed == sales
          ? _value._sales
          : sales // ignore: cast_nullable_to_non_nullable
              as List<Sale>?,
      purchases: freezed == purchases
          ? _value._purchases
          : purchases // ignore: cast_nullable_to_non_nullable
              as List<Purchase>?,
      stocks: freezed == stocks
          ? _value._stocks
          : stocks // ignore: cast_nullable_to_non_nullable
              as List<Stock>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Product implements _Product {
  const _$_Product(
      {this.productId,
      required this.productName,
      this.productDescription,
      required this.price,
      this.supplierId,
      this.brandId,
      final List<Sale>? sales,
      final List<Purchase>? purchases,
      final List<Stock>? stocks})
      : _sales = sales,
        _purchases = purchases,
        _stocks = stocks;

  factory _$_Product.fromJson(Map<String, dynamic> json) =>
      _$$_ProductFromJson(json);

  @override
  final int? productId;
  @override
  final String productName;
  @override
  final String? productDescription;
  @override
  final double price;
  @override
  final int? supplierId;
  @override
  final int? brandId;
  final List<Sale>? _sales;
  @override
  List<Sale>? get sales {
    final value = _sales;
    if (value == null) return null;
    if (_sales is EqualUnmodifiableListView) return _sales;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<Purchase>? _purchases;
  @override
  List<Purchase>? get purchases {
    final value = _purchases;
    if (value == null) return null;
    if (_purchases is EqualUnmodifiableListView) return _purchases;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<Stock>? _stocks;
  @override
  List<Stock>? get stocks {
    final value = _stocks;
    if (value == null) return null;
    if (_stocks is EqualUnmodifiableListView) return _stocks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Product(productId: $productId, productName: $productName, productDescription: $productDescription, price: $price, supplierId: $supplierId, brandId: $brandId, sales: $sales, purchases: $purchases, stocks: $stocks)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Product &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.productDescription, productDescription) ||
                other.productDescription == productDescription) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.supplierId, supplierId) ||
                other.supplierId == supplierId) &&
            (identical(other.brandId, brandId) || other.brandId == brandId) &&
            const DeepCollectionEquality().equals(other._sales, _sales) &&
            const DeepCollectionEquality()
                .equals(other._purchases, _purchases) &&
            const DeepCollectionEquality().equals(other._stocks, _stocks));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      productId,
      productName,
      productDescription,
      price,
      supplierId,
      brandId,
      const DeepCollectionEquality().hash(_sales),
      const DeepCollectionEquality().hash(_purchases),
      const DeepCollectionEquality().hash(_stocks));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ProductCopyWith<_$_Product> get copyWith =>
      __$$_ProductCopyWithImpl<_$_Product>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ProductToJson(
      this,
    );
  }
}

abstract class _Product implements Product {
  const factory _Product(
      {final int? productId,
      required final String productName,
      final String? productDescription,
      required final double price,
      final int? supplierId,
      final int? brandId,
      final List<Sale>? sales,
      final List<Purchase>? purchases,
      final List<Stock>? stocks}) = _$_Product;

  factory _Product.fromJson(Map<String, dynamic> json) = _$_Product.fromJson;

  @override
  int? get productId;
  @override
  String get productName;
  @override
  String? get productDescription;
  @override
  double get price;
  @override
  int? get supplierId;
  @override
  int? get brandId;
  @override
  List<Sale>? get sales;
  @override
  List<Purchase>? get purchases;
  @override
  List<Stock>? get stocks;
  @override
  @JsonKey(ignore: true)
  _$$_ProductCopyWith<_$_Product> get copyWith =>
      throw _privateConstructorUsedError;
}
