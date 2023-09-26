// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../sales_cart_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$salesCartProviderHash() => r'60e55a2740de3f974af7e4ac9a9f4955a674e85a';

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
String _$selectedSalesHash() => r'd7aad39392e7318fa63b7e44725c89c0bab917bc';

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
