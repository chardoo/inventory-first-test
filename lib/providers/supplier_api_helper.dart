import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rich_co_inventory/providers/app_state_provider.dart';

import '../models/supplier.dart';
import '../repository/sections/suppliers_api.dart';

class SupplierApisHelper {
  SupplierApisHelper() : apis = SuppliersApis();
  final SuppliersApis apis;

  Future addBrand(Supplier supplier, WidgetRef ref) async {
    final loadingState = ref.read(loadingStateProvider.notifier);
    loadingState.activate();
    await Future.delayed(Duration(seconds: 2));
    apis.add(supplier);
    loadingState.finish();
    loadingState.diactivate();
  }

  Future<List> getSuppliers() async {
    apis.getAll();
    return [];
  }
}
