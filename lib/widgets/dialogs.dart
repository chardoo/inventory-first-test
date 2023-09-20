import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:rich_co_inventory/providers/app_state_provider.dart';

class MyDialogs {
  static Widget showLoader(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.hexagonDots(
        color: Colors.red,
        size: 200,
      ),
    );
  }
}
