// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../sales_cart_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$salesCartProviderHash() => r'9248c64a029351ce2065366fe4589be8f456fe80';

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
String _$selectedSalesHash() => r'8dc7e2a6f8d951f757697a81db36e7f5ae0de0af';

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
