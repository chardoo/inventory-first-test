import 'package:flutter/material.dart';
import 'package:rich_co_inventory/helpers/navigator.dart';
import 'package:rich_co_inventory/widgets/texts.dart';

import 'button.dart';

class MyDialogs {
  static Widget showLoader(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Center(
        child: SizedBox(
            height: 200, width: 200, child: Image.asset("assets/spinner.gif")),
      ),
    );
  }

  static showConfirm(BuildContext context,
      {Function()? ontap,
      required String title,
      required String message,
      String cancelButtonLabel = "No",
      String acceptLabel = "Ok",
      Function()? onCancel,
      Function()? onAcceptLabel}) {
    showDialog(
        context: context,
        builder: (_) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Align(
                    alignment: Alignment.center,
                    child: MyText(
                      text: title,
                      weight: FontWeight.bold,
                    )),
                MyText(
                  text: message,
                  size: 24,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    CustomButton(
                      label: cancelButtonLabel,
                      bgColor: Colors.redAccent,
                      ontap: onCancel ?? () => MyNavigator.back(context),
                    ),
                    CustomButton(
                      label: acceptLabel,
                      ontap: onAcceptLabel,
                    )
                  ],
                )
              ]),
            ),
          );
        });
  }
}
