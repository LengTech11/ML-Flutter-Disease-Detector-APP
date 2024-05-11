import 'package:flutter/material.dart';

class HelperFunctions {
  /// show snack bar
  // static void showSnackBar(String message) {
  //   ScaffoldMessenger.of(Get.context!)
  //       .showSnackBar(SnackBar(content: Text(message)));
  // }
  //
  // /// show alert
  // static void showAlert(String title, String message) {
  //   showDialog(
  //       context: Get.context!,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text(title),
  //           content: Text(
  //             message,
  //           ),
  //           actions: [
  //             TextButton(
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                 },
  //                 child: Text("Ok"))
  //           ],
  //         );
  //       });
  // }

  /// check is dark mode
  static bool isDarkMode(BuildContext context){
    return Theme.of(context).brightness == Brightness.dark;
  }
}
