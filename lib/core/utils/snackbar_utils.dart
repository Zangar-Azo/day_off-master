import 'package:flutter/material.dart';
import 'package:new_app/core/theme/appTheme.dart';

class SnackUtil {
  static void showError(
      {@required BuildContext context, @required String message}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(message, style: TextStyle(color: Colors.white)),
      ), // SnackBar
    );
  }

  static void showLoading({@required BuildContext context}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.white,
      content: LinearProgressIndicator(),
      duration: Duration(days: 2),
    ));
  }

  static void showInfo(
      {@required BuildContext context, @required String message}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(message, style: TextStyle(color: AppColors.yellow)),
          backgroundColor: AppColors.black), // SnackBar
    );
  }
}
