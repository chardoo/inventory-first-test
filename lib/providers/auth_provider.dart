import 'package:firebase_auth/firebase_auth.dart';
import 'package:rich_co_inventory/helpers/secure_store.dart';
import 'package:rich_co_inventory/providers/app_state_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repository/firebase_auth.dart';
part '.generated/auth_provider.g.dart';

@riverpod
class AuthProvider extends _$AuthProvider {
  AuthProvider() : repo = AuthRepo();
  LoadingStateProvider? loadingStateNotifier;

  final AuthRepo repo;
  @override
  User? build() {
    return null;
  }

  bool get isAuthenticated => state != null;

  initLoader() {
    loadingStateNotifier = ref.read(loadingStateProvider.notifier);
  }

  Future<(bool, String)> logIn({
    required String email,
    required String pwd,
  }) async {
    initLoader();
    loadingStateNotifier?.activate();
    var logInState = await repo.logIn(
      email,
      pwd,
    );

    Storage.setLogIn(logInState.isSuccess);
    loadingStateNotifier?.finish();
    loadingStateNotifier?.diactivate();
    return (logInState.isSuccess, logInState.message ?? "");
  }
}
