import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rich_co_inventory/helpers/secure_store.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/user.dart';
part '.generated/user_provider.g.dart';

@riverpod
class UserProvider extends _$UserProvider {
  @override
  User? build() {
    return null;
  }

  init() async {
    final user = await Storage.getUser();
    state = user.user;
  }

  delete() async {
    state = null;
     Storage.logOut();
  }
}
