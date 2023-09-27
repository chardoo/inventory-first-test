// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../sales_cart_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$salesCartProviderHash() => r'882b5fc3608950de4e089ba78820f313e0264b34';

/// See also [SalesCartProvider].
@ProviderFor(SalesCartProvider)
final salesCartProvider =
    AutoDisposeNotifierProvider<SalesCartProvider, List<Sale>>.internal(
  SalesCartProvider.new,
  name: r'salesCartProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$salesCartProviderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SalesCartProvider = AutoDisposeNotifier<List<Sale>>;
String _$selectedSalesHash() => r'3ad9d5d513e8637f5689e958615187189183054b';

/// See also [SelectedSales].
@ProviderFor(SelectedSales)
final selectedSales =
    AutoDisposeNotifierProvider<SelectedSales, Sale?>.internal(
  SelectedSales.new,
  name: r'selectedSales',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedSalesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedSales = AutoDisposeNotifier<Sale?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
