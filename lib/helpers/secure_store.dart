import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class Storage {
  static const userDataKey = "userData";
  static const logedInKey = "logIn";

  static storeUser(User? user, bool isLoggedIn) async {
    try {
      final storage = await SharedPreferences.getInstance();
      final data = user?.toJson();
      final encoded = data == null ? null : jsonEncode(data);
      storage.setBool(logedInKey, isLoggedIn);
      storage.setString(userDataKey, encoded ?? "");
      return true;
    } catch (e) {
      return false;
    }
  }

  static logOut() async {
    try {
      final storage = await SharedPreferences.getInstance();
      storage.setBool(logedInKey, false);
      storage.clear();
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<({User? user, bool isLoggedIn})> getUser() async {
    try {
      final storage = await SharedPreferences.getInstance();
      final isLoggedIn = storage.getBool(logedInKey) ?? false;
      final userData = storage.getString(userDataKey) ?? "";
      if (userData.isNotEmpty && isLoggedIn) {
        final decoded = json.decode(userData);
        return (user: User.fromJson(decoded), isLoggedIn: isLoggedIn);
      }
      return (user: null, isLoggedIn: false);
    } catch (e) {
      return (user: null, isLoggedIn: false);
    }
  }
}
