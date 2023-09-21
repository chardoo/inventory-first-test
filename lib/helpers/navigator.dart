import 'package:flutter/material.dart';

class MyNavigator {
  static goto(BuildContext context, Widget screen) {
    return Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }
}
