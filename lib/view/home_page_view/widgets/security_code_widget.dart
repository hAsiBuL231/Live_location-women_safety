import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../.data/user_data_SharedPreferences/app_user_data.dart';
import '../../../.resources/colours/app_colours.dart';
import '../../../models/user_models.dart';

/// ///////////////////////////    Your security code   ///////////////////////////

Widget securityCodeView = Padding(
    padding: const EdgeInsets.all(10),
    child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: AppColours.secondaryBackground,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Column(mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.center, children: [
            Padding(
                padding: const EdgeInsets.all(6),
                child: AutoSizeText('Your security code',
                    maxLines: 1, style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w800, fontFamily: GoogleFonts.manrope.toString()))),
            const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 0, 10, 0),
                child: AutoSizeText('Share security code so your friends can connect and track your location',
                    maxLines: 2, style: TextStyle(color: Colors.black, fontSize: 14))),
            Padding(
                padding: const EdgeInsets.all(6),
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: AppColours.alternate,
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(20, 8, 20, 8),
                      /*child: Consumer<UserDataProvider>(
                        builder: (context, value, child) {
                          return AutoSizeText("${value.userData!.name}",
                              maxLines: 1, style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold, fontFamily: GoogleFonts.manrope.toString()));
                        },
                      )*/
                      child: SelectionArea(
                        child: Selector<UserDataProvider, Users?>(
                            selector: (_, provider) => provider.userData,
                            builder: (_, userData, __) {
                              if (userData != null) {
                                return AutoSizeText("${userData.securityCode}",
                                    maxLines: 1,
                                    style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold, fontFamily: GoogleFonts.manrope.toString()));
                              }
                              return const Text("");
                            }),
                      )),
                )),
          ]),
        )));
