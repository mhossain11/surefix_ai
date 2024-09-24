/*
 *
 *  @author  Md. Touhidul Islam
 *  @since 12/13/21 11:25 PM
 *
 */

import 'package:flutter/material.dart';

import '../utils/colors.dart';
import 'ProjectResource.dart';

class SnackBars {
  static closeSnackBar(context){

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }
  static showSnackBar(
      {required BuildContext context,
      required String content,
      required bool success,
      bool actionShow = false,
      dynamic routeAction,
      int durationSec = 2}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: success ?Colors.transparent:Colors.red,
      content: Row(
        children: [
          success
              ? const Icon(
                  Icons.done_all,
                  color: green,
                )
              : const Icon(
                  Icons.error_outline_sharp,
                  color: Colors.black,
                ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
              child: Text(
            content,
            //style: TextStyle(fontSize: ProjectResource.headerFontSize! * .8),
            style: const TextStyle(fontSize: 14),
          )),
        ],
      ),
      duration: Duration(seconds: durationSec),
      action: SnackBarAction(
        label: 'Close',
        textColor: Colors.black,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    ));
  }
}
