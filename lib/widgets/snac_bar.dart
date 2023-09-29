import 'package:flutter/material.dart';

class MySnackBar {
  static showSnack(String message, BuildContext context) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
