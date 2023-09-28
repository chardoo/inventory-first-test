import 'package:flutter/material.dart';
import 'package:rich_co_inventory/helpers/navigator.dart';
import 'package:rich_co_inventory/screens.dart/shared/widgets/texts.dart';

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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Align(
                    alignment: Alignment.center,
                    child: MyText(
                      text: title,
                      size: 24,
                      weight: FontWeight.bold,
                    )),
                const SizedBox(height: 20),
                MyText(
                  text: message,
                  size: 24,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      label: cancelButtonLabel,
                      width: 100,
                      bgColor: Colors.redAccent,
                      ontap: onCancel ?? () => MyNavigator.back(context),
                    ),
                    CustomButton(
                      label: acceptLabel,
                      width: 100,
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
