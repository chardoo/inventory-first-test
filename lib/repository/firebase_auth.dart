import 'package:firebase_auth/firebase_auth.dart';
import 'package:rich_co_inventory/repository/firestore_apis.dart';

class AuthState {
  final String? message;
  final bool isSuccess;

  AuthState({this.isSuccess = false, this.message})
      : assert(isSuccess ? message == null : message != null);
}

class AuthRepo extends FireStoreAPIs<User> {
  String get userCollection => Collections.user.name;
  Future<AuthState> logIn(
      String email, String password,) async {
    try {
      final res = await instance
          .collection(userCollection)
          .where("email", isEqualTo: email.trim())
          .limit(1)
          .get();

      if (res.docs.isNotEmpty) {
        final user = res.docs.first;
        if (user['password'] == password) {
          return AuthState(isSuccess: true);
        } else {
          return AuthState(isSuccess: false, message: "Wrong password");
        }
      }
      return AuthState(isSuccess: false, message: "User does not exit");
    } catch (e) {
      return AuthState(isSuccess: false, message: "sorry an error occured");
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
  String get mainCollection => throw UnimplementedError();

  @override
  update(User item) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
