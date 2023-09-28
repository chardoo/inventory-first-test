import 'package:flutter/material.dart';

class MyNavigator {
  static goto(BuildContext context, Widget screen) {
    return Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  static back(BuildContext context) {
    return Navigator.pop(context);
  }

  static backTo(BuildContext context, {String path = "/"}) {
    return Navigator.popUntil(context, ModalRoute.withName(path));
  }
}
