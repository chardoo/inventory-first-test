import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo {
  final FirebaseAuth instance;
  AuthRepo() : instance = FirebaseAuth.instance;

  Future<User?> logIn(
      String email, String pwd, Function(String err) onError) async {
    try {
      final userCredentials = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pwd);
      return userCredentials.user!;
    } on FirebaseAuthException catch (e) {
      onError("${e.message}");
      return null;
    }
  }
}
