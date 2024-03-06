import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter_track_live/.resources/colours/app_colours.dart';

class Utils {
  static void fieldFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static showToast (String message){
    Fluttertoast.showToast(msg: message, backgroundColor: AppColours.blackColour, gravity: ToastGravity.BOTTOM);
  }

  static snackBar (String title, String message){
    Get.snackbar(title, message);
  }
}
