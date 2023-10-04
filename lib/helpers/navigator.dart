import 'package:flutter/material.dart';

class MyNavigator {
  static const home = "/";
  static const logIn = "/logged-in";
  static const salesPage = "/sales";
  static const addProduct = "/add-product";
  static const addSales = "/add-sales";

  static goto(BuildContext context, Widget screen) {
    return Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return screen;
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);
            return SlideTransition(position: offsetAnimation, child: child);
          },
        ));
  }

  static back(BuildContext context) {
    return Navigator.pop(context);
  }

  static pushAndReplace(BuildContext context, String path) {
    return Navigator.popAndPushNamed(context, path);
  }

  static popAndPush(BuildContext context, String path) {
    return Navigator.popAndPushNamed(context, path);
  }

  static backTo(BuildContext context, {String path = home}) {
    return Navigator.popUntil(context, ModalRoute.withName(path));
  }
}
