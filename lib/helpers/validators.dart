import 'package:flutter/material.dart';

class MyValidators {
  static bool isEmpty(String text) {
    return text.isEmpty;
  }

  static bool isNumber(String text) {
    final RegExp numberRegex = RegExp(r'^\d+(\.\d+)?$');
    return numberRegex.hasMatch(text);
  }

  static (bool, String) isNotNumberAndIsEmpty(String val, {String? name}) {
    if (isEmpty(val)) {
      return (true, "Please enter a ${name ?? 'value'}");
    } else if (!isNumber(val)) {
      return (true, "Please enter a valid ${name ?? 'value'}");
    }
    return (false, "");
  }

  static (bool, String) isEmail(String text) {
    final RegExp emailRegex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$',
      caseSensitive: false,
    );
    bool hasMatch = emailRegex.hasMatch(text);
    if (hasMatch) {
      return (true, "");
    }
    return (false, "Please enter a valid password");
  }

  static (bool, String) isPasswordValid(String password) {
    final RegExp passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d).+$');

    final hasMatch = passwordRegex.hasMatch(password);
    if (hasMatch) {
      return (true, "");
    }
    return (false, "Please enter a valid password");
  }
}
