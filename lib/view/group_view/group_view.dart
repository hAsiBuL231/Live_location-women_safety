import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_track_live/.utils/Functions.dart';
import 'package:flutter_track_live/components/button.dart';
import 'package:flutter_track_live/components/list_tile.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../.data/network/network_api_services.dart';
import '../../.resources/app_url/AppUrl.dart';
import '../../.resources/colours/app_colours.dart';
import '../../models/user_models.dart';
import '../forms/AddMemberForm.dart';
import '../forms/CreateGroupForm.dart';
import '../map_view/MapPage.dart';

class GroupViewWidget extends StatefulWidget {
  final List<String> idList;
  const GroupViewWidget({super.key, required this.idList});

  @override
  State<GroupViewWidget> createState() => _GroupViewWidgetState();
}

class _GroupViewWidgetState extends State<GroupViewWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Members')),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: 10),
        //customButton(onPress: () {}, bgColor: Colors.black,width: 200,text: "Create New Group"),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 12),
          child: Row(mainAxisSize: MainAxisSize.max, children: [
            Expanded(
                child: TextFormField(
                    //controller: _model.textController,
                    //focusNode: _model.textFieldFocusNode,
                    onChanged: (_) {},
                    onFieldSubmitted: (_) async {},
                    //autofocus: true,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Search members...',
                      enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white, width: 2), borderRadius: BorderRadius.circular(12)),
                      focusedBorder: OutlineInputBorder(borderSide: const BorderSide(width: 2), borderRadius: BorderRadius.circular(12)),
                      errorBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.red, width: 2), borderRadius: BorderRadius.circular(12)),
                      focusedErrorBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.red, width: 2), borderRadius: BorderRadius.circular(12)),
                      filled: true,
                      //fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                    ))),
            Padding(padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0), child: FloatingActionButton(onPressed: () {}, child: const Icon(Icons.search_rounded))),
          ]),
        ),
        const Padding(
          padding: EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
          child: Text('Members in Group'),
        ),
        Container(
          width: double.infinity,
          height: 160,
          decoration: const BoxDecoration(),
          child: ListView(padding: EdgeInsets.zero, primary: false, shrinkWrap: true, scrollDirection: Axis.horizontal, children: [
            Padding(
                padding: const EdgeInsetsDirectional.all(12),
                child: Container(
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [BoxShadow(blurRadius: 4, color: Color(0x34090F13), offset: Offset(0, 2))],
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                              'https://images.unsplash.com/photo-1614436163996-25cee5f54290?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTJ8fHVzZXJ8ZW58MHx8MHx8&auto=format&fit=crop&w=900&q=60',
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            )),
                        Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                            child: Text('UserName', style: TextStyle(color: AppColours.blackColour, fontSize: 12, fontFamily: GoogleFonts.manrope.toString()))),
                        Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                            child: Text('Remove',
                                style: TextStyle(color: AppColours.blackColour, fontSize: 12, fontWeight: FontWeight.w800, fontFamily: GoogleFonts.manrope.toString()))),
                      ]),
                    ))),
            Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                child: Container(
                    width: 100,
                    //height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [BoxShadow(blurRadius: 4, color: Color(0x34090F13), offset: Offset(0, 2))],
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                                'https://images.unsplash.com/photo-1531427186611-ecfd6d936c79?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZmlsZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=900&q=60',
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover)),
                        Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                            child: Text('UserName', style: TextStyle(color: AppColours.blackColour, fontSize: 12, fontFamily: GoogleFonts.manrope.toString()))),
                        Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                            child: Text('Remove',
                                style: TextStyle(color: AppColours.blackColour, fontSize: 12, fontWeight: FontWeight.w800, fontFamily: GoogleFonts.manrope.toString()))),
                      ]),
                    ))),
            Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
                child: Container(
                    width: 100,
                    //height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [BoxShadow(blurRadius: 4, color: Color(0x34090F13), offset: Offset(0, 2))],
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                              'https://images.unsplash.com/photo-1529665253569-6d01c0eaf7b6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8cHJvZmlsZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=900&q=60',
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            )),
                        Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                            child: Text('UserName', style: TextStyle(color: AppColours.blackColour, fontSize: 12, fontFamily: GoogleFonts.manrope.toString()))),
                        Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                            child: Text('Remove',
                                style: TextStyle(color: AppColours.blackColour, fontSize: 12, fontWeight: FontWeight.w800, fontFamily: GoogleFonts.manrope.toString()))),
                      ]),
                    ))),
          ]),
        ),

        const Padding(
          padding: EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
          child: Text(
            'Members list',
          ),
        ),

        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
                padding: const EdgeInsets.all(10),
                child: FloatingActionButton.extended(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  onPressed: () => nextPage(const AddMemberForm(), context),
                  elevation: 5,
                  backgroundColor: AppColours.tertiary,
                  label: AutoSizeText("Add Member",
                      style: TextStyle(color: AppColours.primaryBackground, fontSize: 12, fontWeight: FontWeight.w800, fontFamily: GoogleFonts.manrope.toString())),
                )),
          ],
        ),
        const SizedBox(height: 10),
        FutureBuilder(
          future: NetworkApiServices().getApi(AppUrl.userCollectionUrl),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());

            /// /////////////////////////////////// Finding the user data   //////////////////////////////
            var response = snapshot.data['documents'];
            var users = response.map((doc) => Users.fromJson(doc));

            /// /////////////////////////////////// Finding the user data   //////////////////////////////
            return ListView.builder(
              shrinkWrap: true,
              itemCount: widget.idList.length,
              itemBuilder: (context, index) {
                var matchedUsers = users.where((users) => users.securityCode == widget.idList[index]).toList();
                return customListTile(
                    title: matchedUsers[0].name,
                    imageUrl: matchedUsers[0].imageUrl,
                    subTitle: 'See live location..',
                    onPress: () => nextPage(MapPage(securityCode: matchedUsers[0].securityCode), context));
                //return customListTile(title: widget.idList[index]);
              },
            );
          },
        ),
        /*ListView.builder(
          shrinkWrap: true,
          itemCount: widget.idList.length,
          itemBuilder: (context, index) {
            return customListTile(title: widget.idList[index]);
          },
        )*/
      ]),
    );
  }
}
