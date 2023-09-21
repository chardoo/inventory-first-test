import 'package:firebase_auth/firebase_auth.dart';
import 'package:rich_co_inventory/repository/firestore_apis.dart';

class AuthRepo extends FireStoreAPIs<User> {
  String get userCollection => Collections.user.name;
  Future<dynamic> logIn(
      String email, String password, dynamic Function(String) onError) async {
    try {
      final res = await instance.collection(userCollection).doc(email).get();
      print(res.data());
      if (res.data()!.isNotEmpty) {
        if (res.data()!['password'] == password) {
          return true;
        }
      } else {
        return false;
      }
    } catch (e) {
      return null;
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
