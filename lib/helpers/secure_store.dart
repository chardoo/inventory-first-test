import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static const logedInKey = "logIn";
 static Future setLogIn(bool isLoggedIn) async {
    try {
      final storage = await SharedPreferences.getInstance();
      storage.setBool(logedInKey, isLoggedIn);
      return true;
    } catch (e) {
      return false;
    }
  }

 static Future<bool> getLogIn() async {
    try {
      final storage = await SharedPreferences.getInstance();
      final res = storage.getBool(logedInKey);
      return res ?? false;
    } catch (e) {
      return false;
    }
  }
}
