import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../resource/_index.dart';

class CommonWidgets {
  // —————————————————————————————————————————————————————————————————————————
  // SNACK BAR —————————————————————————————————————————————————————————
  // —————————————————————————————————————————————————————————————————————————
  void snackBar({
    required String title,
    required String message,
    SnackPosition position = SnackPosition.TOP,
    int durationInSecond = 2,
  }) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.black45,
      barBlur: 8.0,
      snackPosition: position,
      margin: EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0, top: 30),
      duration: Duration(seconds: durationInSecond),
    );
  }

  void snackBarError({
    String title = "Gagal",
    String message = "",
    SnackPosition position = SnackPosition.TOP,
    int durationInSecond = 2,
  }) {
    Get.snackbar(title, message,
        backgroundColor: Color.fromARGB(173, 255, 255, 255),
        borderWidth: 1,
        borderColor: Color.fromARGB(115, 208, 208, 208),
        barBlur: 8.0,
        snackPosition: position,
        margin: EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0, top: 30),
        duration: Duration(seconds: durationInSecond),
        icon: Icon(Icons.error, color: Colors.red));
  }

  void snackBarSuccess({
    String title = "",
    String message = "",
    SnackPosition position = SnackPosition.TOP,
    int durationInSecond = 2,
  }) {
    Get.snackbar(title, message,
        backgroundColor: Color(0x8A2E7D32),
        barBlur: 8.0,
        snackPosition: position,
        margin: EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0, top: 30),
        duration: Duration(seconds: durationInSecond),
        icon: Icon(Icons.check_circle, color: Colors.white));
  }

  void RadiusToast({
    required String message,
    Color? textColor = colorWhite,
    Color? toastColor = Colors.black87,
    ToastGravity? toastPosition = ToastGravity.BOTTOM,
    int duration = 1,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: toastPosition,
      timeInSecForIosWeb: 1,
      backgroundColor: toastColor,
      textColor: textColor,
      fontSize: 14.0,
    );
  }


  // —————————————————————————————————————————————————————————————————————————
  // CONTAINER BORDER  ———————————————————————————————————————————————————————
  // —————————————————————————————————————————————————————————————————————————
  BoxDecoration boxBottomSheetRadiusDecoration({double radius = 16}) {
    return BoxDecoration(
      color: colorWhite,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(radius),
        topRight: Radius.circular(radius),
      ),
    );
  }

}
