import 'package:flutter/material.dart';
import 'package:rich_co_inventory/screens.dart/shared/widgets/dialogs.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part '.generated/app_state_provider.g.dart';

@riverpod
class LoadingStateProvider extends _$LoadingStateProvider {
  @override
  LoadingState build() {
    return InActive();
  }

  bool get isAppLoading => state is Active;
  void activate() {
    state = Active();
  }

  void finish() {
    state = FinishLoading();
  }

  void diactivate() {
    state = InActive();
  }
}

abstract class LoadingState {
  Widget show(BuildContext context);
}

class Active extends LoadingState {
  @override
  Widget show(BuildContext context) {
    return MyDialogs.showLoader(context);
  }
}

class FinishLoading extends LoadingState {
  @override
  show(BuildContext context) {
    return const SizedBox.shrink();
  }
}

class InActive extends LoadingState {
  @override
  show(BuildContext context) {
    return const SizedBox.shrink();
  }
}
