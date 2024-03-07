import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_track_live/.data/network/network_api_services.dart';
import 'package:flutter_track_live/.resources/app_url/AppUrl.dart';
import 'package:flutter_track_live/.utils/Functions.dart';
import 'package:flutter_track_live/components/list_tile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../.data/user_data_SharedPreferences/app_user_data.dart';
import '../../../.resources/colours/app_colours.dart';
import '../../../models/group_models.dart';
import '../../forms/CreateGroupForm.dart';
import '../../../components/customForm.dart';
import '../../group_page_view/group_page_view.dart';

/// ///////////////////////////    Create new Group   ///////////////////////////
Widget groupListWidget(BuildContext context) {
  final userProvider = Provider.of<UserDataProvider>(context, listen: false);

  if (userProvider.userData != null) {
    return Column(children: [
      /// ///////////////////////////    Create new Group Button  ///////////////////////////

      Padding(
          padding: const EdgeInsets.all(10),
          child: FloatingActionButton.extended(
            onPressed: () => nextPage(const CreateGroupForm(), context),
            elevation: 10,
            backgroundColor: AppColours.tertiary,
            label: AutoSizeText("Create New Group",
                maxLines: 1,
                style: TextStyle(color: AppColours.primaryBackground, fontSize: 18, fontWeight: FontWeight.w800, fontFamily: GoogleFonts.manrope.toString())),
          )),

      /// ///////////////////////////    Group List from firebase ///////////////////////////

      FutureBuilder(
        future: NetworkApiServices().getApi("${AppUrl.userCollectionUrl}/${userProvider.userData?.securityCode}/group"),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
          if (!snapshot.hasData) return Center(child: Text(snapshot.error.toString()));

          var groups = snapshot.data['documents'];
          print(" \n \n \n groupListWidget Snapshot:          ${snapshot.data.toString()}");

          if (groups == null) {
            return Center(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("No group", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: GoogleFonts.aboreto.toString())),
            ));
          }

          return Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: groups.length,
              itemBuilder: (context, index) {
                print(" \n \n \n groupListWidget groups[index]:      ${groups[index]}");

                Group group = Group.fromJson(groups[index]);
                //print(" \n \n \n itemBuilder:      ${group.toJson()}");

                String? g_ID = group.groupId;
                String? g_name = group.name.toString();
                String? g_image = group.image.toString();
                String? g_idListLenght = group.idList.length.toString();

                return customListTile(
                    title: g_name, subTitle: 'Members: $g_idListLenght', imageUrl: g_image, onPress: () => nextPage(GroupViewWidget(passedGroup: group), context));
              },
            ),
          );
        },
      ),
    ]);
  } else {
    return Text("Something is wrong!");
  }
}
