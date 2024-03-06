import 'package:flutter/material.dart';


Widget customButton(
    {required VoidCallback onPress,
      required String text,
      double? fontSize = 15,
      FontWeight? fontWeight,
      double? width,
      double padding = 10,
      double? margin = 0,
      Color? fontColor,
      Color? bgColor,
      bool iconPrefix = false,
      IconData? icon,
      bool roundedRectangleBorder = false,
      Color? borderColor,
      double? borderRadius,
      Color? iconColor}) {
  return Container(
    width: width,
    margin: EdgeInsets.all(margin ?? 0),
    child: TextButton(
        onPressed: onPress,
        style: ButtonStyle(
            shape: roundedRectangleBorder
                ? MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius ?? 4.0), side: BorderSide(color: borderColor ?? Colors.blue, width: 2)))
                : null,
            backgroundColor: roundedRectangleBorder ? MaterialStateProperty.all(bgColor) : MaterialStateProperty.all(bgColor),
            padding: MaterialStateProperty.all(EdgeInsets.all(padding))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon == null) ...[] else if (iconPrefix) ...[Icon(icon, color: iconColor), const SizedBox(width: 5)],
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(color: fontColor, fontSize: fontSize, fontWeight: fontWeight),
            ),
            if (icon == null) ...[] else if (!iconPrefix) ...[const SizedBox(width: 5), Icon(icon, color: iconColor)]
          ],
        )),
  );
}