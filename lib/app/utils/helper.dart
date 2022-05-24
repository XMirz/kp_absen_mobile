import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kp_mobile/app/values/colors.dart';

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
  static Future<void> showConfirmationDialog({
    required String title,
    required String message,
    bool? showCancel = true,
    Function? onConfirm,
    Function? onCancel,
    String? textConfirm,
    String? textCancel,
    bool? barrierDismissible,
  }) async {
    await Get.dialog(
      AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          showCancel == true
              ? TextButton(
                  onPressed: () => Get.back(),
                  child: Text(
                    textCancel ?? 'Batal',
                    style: TextStyle(
                      color: AppColor.secondaryLight,
                    ),
                  ),
                )
              : Container(),
          textConfirm != null || onConfirm != null
              ? TextButton(
                  onPressed: () => onConfirm != null
                      ? () {
                          onConfirm();
                        }()
                      : () {
                          Get.back();
                        }(),
                  child: Text(
                    textConfirm ?? 'Konfirmasi',
                    style: TextStyle(),
                  ),
                )
              : Container(),
        ],
      ),
      barrierDismissible: barrierDismissible ?? true,
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
