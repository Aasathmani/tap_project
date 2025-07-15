import 'package:flutter/material.dart';

class SnackBarHelper {
  static void show(
      BuildContext context,
      String message, {
        Color backgroundColor = Colors.black,
        Duration duration = const Duration(seconds: 2),
        SnackBarAction? action,
      }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        action: action,
      ),
    );
  }
}
