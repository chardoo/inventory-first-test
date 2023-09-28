import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rich_co_inventory/providers/app_state_provider.dart';

class LoadingLayout extends ConsumerWidget {
  const LoadingLayout({required this.child, super.key});
  final Widget child;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loadingState = ref.watch(loadingStateProvider);
    return Stack(children: [
      child,
      WillPopScope(
          onWillPop: () async =>
              !ref.read(loadingStateProvider.notifier).isAppLoading,
          child: loadingState.show(context))
    ]);
  }
}
