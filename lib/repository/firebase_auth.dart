import 'package:firebase_core/firebase_core.dart';
import 'package:rich_co_inventory/helpers/secure_store.dart';
import 'package:rich_co_inventory/repository/firestore_apis.dart';

import '../models/user.dart';

class AuthState {
  final String? message;
  final bool isSuccess;

  AuthState({this.isSuccess = false, this.message})
      : assert(isSuccess ? message == null : message != null);
}

class AuthRepo extends FireStoreAPIs<User> {
  String get userCollection => Collections.users.name;
  Future<({User? user, bool isSuccess, String? error})> logIn(
    String email,
    String password,
  ) async {
    try {
      final res = await instance
          .collection(userCollection)
          .where("email", isEqualTo: email.trim())
          .limit(1)
          .get();

      if (res.docs.isNotEmpty) {
        final userPsw = res.docs.first["password"];
        if (userPsw == password) {
          final user = User.fromJson(res.docs.first.data());
          return (user: user, isSuccess: true, error: null);
        } else {
          return (user: null, isSuccess: false, error: "wrong password");
        }
      }
      return (user: null, isSuccess: false, error: "User does not exist");
    } on FirebaseException catch (e) {
      return (
        user: null,
        isSuccess: false,
        error: e.message ?? "sorry an error occured"
      );
    } catch (e) {
      return (user: null, isSuccess: false, error: "sorry an error occured");
    }
  }

  @override
  Future add(User item) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  delete(User item) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  // TODO: implement dependantCollection
  String get dependantCollection => throw UnimplementedError();

  @override
  Future<List<User>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<User?> getOne(String name) {
    // TODO: implement getOne
    throw UnimplementedError();
  }

  @override
  // TODO: implement mainCollection
  String get mainCollection => "users";

  @override
  update(User item) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
