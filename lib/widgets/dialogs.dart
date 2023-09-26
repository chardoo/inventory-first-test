import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:rich_co_inventory/providers/app_state_provider.dart';

class MyDialogs {
  static Widget showLoader(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black.withOpacity(0.3),
      elevation: 5,
      child: Center(
        child: LoadingAnimationWidget.hexagonDots(
          color: Colors.red,
          size: 200,
        ),
      ),
    );
  }
}
