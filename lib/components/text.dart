import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

Widget customText(
    {String? text,
      Color? color,
      double fontSize = 20,
      FontWeight? fontWeight = FontWeight.normal,
      TextAlign textAlign = TextAlign.start,
      int? maxLine,
      bool Underline = false,
      bool isFadeAble = false,
      VoidCallback? onCallBack}) {
  return InkWell(
    onTap: onCallBack,
    child: SizedBox(
      child: AutoSizeText(
        "$text",
        textAlign: textAlign,
        maxLines: maxLine,
        textDirection: TextDirection.ltr,
        overflow: isFadeAble ? TextOverflow.ellipsis : null,
        style: TextStyle(
            decoration: Underline ? TextDecoration.underline : null,
            decorationColor: Underline ? Colors.blue : null,
            color: color,
            fontSize: fontSize,
            fontWeight: fontWeight),
      ),
    ),
  );
}
