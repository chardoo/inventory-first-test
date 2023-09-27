import 'package:flutter/material.dart';
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


  static  showConfirm(BuildContext context, { Function()? ontap,required String message}){
 showDialog(
                          context: context,
                          builder: (_) {
                            return Dialog(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 10),
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                       MyText(
                                        text: message,
                                        weight: FontWeight.bold,
                                        size: 24,
                                      ),
                                      const SizedBox(height: 12),
                                      CustomButton(
                                        label: "Add",
                                        ontap: ontap,
                                      )
                                    ]),
                              ),
                            );
                          });
  }
}
