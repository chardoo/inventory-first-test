import 'package:firebase_auth/firebase_auth.dart';
import 'package:rich_co_inventory/providers/app_state_provider.dart';
import 'package:rich_co_inventory/repository/firestore_apis.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repository/firebase_auth.dart';
part '.generated/auth_provider.g.dart';

@riverpod
class AuthProvider extends _$AuthProvider {
  AuthProvider() : repo = AuthRepo() {}
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

  Future logIn(
      {required String email,
      required String pwd,
      required Function(String err) onError}) async {
    initLoader();
    loadingStateNotifier?.activate();
    User? user = await repo.logIn(email, pwd, onError);
    if (user != null) {
      print("name is ${user.email}");
      state = user;
    }
    loadingStateNotifier?.finish();
    loadingStateNotifier?.diactivate();
  }
}
