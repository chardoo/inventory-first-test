import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rich_co_inventory/repository/sections/brand_apis.dart';

import '../models/brand.dart';
import 'app_state_provider.dart';

class BrandAPIsHelper {
  BrandAPIsHelper() : apis = BrandAPIs();
  final BrandAPIs apis;

  add(Brand brand,WidgetRef ref)async{
    final loadingState = ref.read(loadingStateProvider.notifier);
    loadingState.activate();
    await Future.delayed(Duration(seconds: 2));
    apis.add(brand);
    loadingState.finish();
    loadingState.diactivate();
  }
}
