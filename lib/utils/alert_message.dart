import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AlertMessage {
  static showAlertMessage(String message,
          {textColor = Colors.white, int duration = 4}) =>
      Fluttertoast.showToast(
          msg: message.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: duration,
          fontSize: 16.0);
}
