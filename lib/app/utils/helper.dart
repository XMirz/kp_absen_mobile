import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Helper {
  Helper.showSnackBar(String message,
      {Duration? duration, Color? color, Color? backgroundColor}) {
    Get.rawSnackbar(
      animationDuration: Duration(milliseconds: 500),
      duration: duration ?? Duration(seconds: 2),
      backgroundColor: backgroundColor ?? Color(0xFF303030),
      messageText: Text(
        message,
        style: TextStyle(color: color ?? Colors.white),
      ),
      borderRadius: 8,
      margin: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
    );
  }
}

Widget spaceY(double height) {
  return SizedBox(
    height: height,
  );
}

Widget spaceX(double width) {
  return SizedBox(
    width: width,
  );
}
