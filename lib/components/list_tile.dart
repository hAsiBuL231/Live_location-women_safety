import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget customListTile({String? title, String? subTitle, String? imageUrl, VoidCallback? onPress}) {
  return Padding(
      padding: const EdgeInsets.all(10),
      child: Material(
        color: Colors.transparent,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [BoxShadow(blurRadius: 0, color: Color(0xFFE0E3E7), offset: Offset(0, 1))],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(mainAxisSize: MainAxisSize.max, children: [
                imageUrl != null
                    ? Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(color: const Color(0x4C4B39EF), shape: BoxShape.circle, border: Border.all(color: const Color(0xFF4B39EF), width: 2)),
                        child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: Image.network("$imageUrl", width: 60, height: 60, fit: BoxFit.cover),
                            )))
                    : Container(),
                Expanded(
                    child: Column(mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.start, children: [
                  title != null
                      ? Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                          child: AutoSizeText("$title",
                              style: TextStyle(
                                  color: const Color(0xFF14181B), fontSize: 16, fontWeight: FontWeight.w500, fontFamily: GoogleFonts.plusJakartaSans.toString())))
                      : Container(),
                  subTitle != null
                      ? Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(12, 4, 0, 0),
                          child: AutoSizeText('$subTitle',
                              style: TextStyle(
                                  color: const Color(0xFF57636C), fontSize: 14, fontWeight: FontWeight.w500, fontFamily: GoogleFonts.plusJakartaSans.toString())))
                      : Container(),
                ])),
                onPress != null
                    ? InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: onPress,
                        child: Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          color: const Color(0xFFF1F4F8),
                          elevation: 1,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                          child: const Padding(padding: EdgeInsets.all(4), child: Icon(Icons.keyboard_arrow_right_rounded, color: Color(0xFF57636C), size: 24)),
                        ))
                    : Container(),
              ]),
            )),
      ) /*.animateOnPageLoad(animationsMap['containerOnPageLoadAnimation1']!),*/
      );
}
