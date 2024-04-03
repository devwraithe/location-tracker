import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class SnackHelper {
  static all(BuildContext context, String title, String message, Color color) {
    return Flushbar(
      title: title,
      titleColor: Colors.white,
      message: message,
      flushbarPosition: FlushbarPosition.BOTTOM,
      flushbarStyle: FlushbarStyle.GROUNDED,
      backgroundColor: color,
      isDismissible: false,
      duration: const Duration(seconds: 4),
    )..show(context);
  }

  static error(BuildContext context, String message) {
    return all(context, "Error", message, Colors.red);
  }

  static success(BuildContext context, String message) {
    return all(context, "Success", message, Colors.green);
  }
}
