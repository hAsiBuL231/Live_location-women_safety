import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../.resources/colours/app_colours.dart';
import '../../../view_models/home_page_model/HomePageModel.dart';

final homePageVM = Get.put(HomePageModel());

Widget radioButton(context) {
  return Obx(
    () => Card(
      color: AppColours.tertiary,
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SwitchListTile.adaptive(
        value: homePageVM.switchListTileValue.value,
        onChanged: (newValue) async {
          homePageVM.switchListTileValue.value = newValue;
          //setState(() => switchListTileValue = newValue);
          if (newValue == true) {
            homePageVM.listenLocation(context);
          } else {
            homePageVM.stopListening();
          }
        },
        title: AutoSizeText('Enable Live Location',
            maxLines: 1, style: TextStyle(color: AppColours.primaryBackground, fontSize: 24, fontWeight: FontWeight.w800, fontFamily: GoogleFonts.manrope.toString())),
        subtitle: AutoSizeText('Friends can see your live location...',
            maxLines: 1, style: TextStyle(color: AppColours.primaryBackground, fontSize: 12, fontWeight: FontWeight.w500, fontFamily: GoogleFonts.manrope.toString())),
        tileColor: AppColours.tertiary,
        activeColor: AppColours.secondaryBackground,
        activeTrackColor: AppColours.primary,
        dense: false,
        controlAffinity: ListTileControlAffinity.trailing,
        contentPadding: const EdgeInsetsDirectional.fromSTEB(20, 0, 16, 0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    ),
  );
}
