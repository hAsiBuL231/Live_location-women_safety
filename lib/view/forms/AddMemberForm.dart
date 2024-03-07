// AddMemberForm

import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_track_live/view/group_page_view/group_page_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../.data/user_data_SharedPreferences/app_user_data.dart';
import '../../.utils/Functions.dart';
import '../../models/group_models.dart';

class AddMemberForm extends StatefulWidget {
  final Group passedGroup;
  const AddMemberForm({super.key, required this.passedGroup});

  @override
  State<AddMemberForm> createState() => _AddMemberFormState();
}

class _AddMemberFormState extends State<AddMemberForm> {
  TextEditingController securityCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 4),
          child: Container(
            alignment: AlignmentDirectional.center,
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(color: Colors.white12),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
                Padding(
                    padding: const EdgeInsets.all(12),
                    child: Container(
                      width: double.infinity,
                      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.9),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [const BoxShadow(blurRadius: 3, color: Color(0x33000000), offset: Offset(0, 1))],
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.black, width: 1),
                      ),
                      child: SingleChildScrollView(
                        child: Column(mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Form(
                            autovalidateMode: AutovalidateMode.always,
                            child: Padding(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                                      child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                        Expanded(
                                          child: Column(mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.start, children: [
                                            Padding(
                                                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
                                                child: Text(
                                                  'Add New Member',
                                                  style: TextStyle(fontSize: 20, fontFamily: GoogleFonts.manrope.toString(), color: Colors.black),
                                                )),
                                            Padding(
                                                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                                                child: Text(
                                                  'Please enter the information below to add.',
                                                  style: TextStyle(fontSize: 12, fontFamily: GoogleFonts.manrope.toString(), color: Colors.black),
                                                )),
                                          ]),
                                        ),
                                        CloseButton(onPressed: () => Navigator.pop(context)),
                                      ]),
                                    ),
                                    Form(
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                                        child: TextFormField(
                                          onTap: () {},
                                          controller: securityCodeController,
                                          //focusNode: _model.projectNameFocusNode,
                                          //autofocus: true,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            hintText: 'Enter his/her security code',
                                            hintStyle: TextStyle(fontSize: 14, fontFamily: GoogleFonts.manrope.toString(), color: Colors.black),
                                            enabledBorder: const UnderlineInputBorder(
                                              borderSide: BorderSide(color: Colors.black, width: 2),
                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(4.0), topRight: Radius.circular(4.0)),
                                            ),
                                            focusedBorder: const UnderlineInputBorder(
                                              borderSide: BorderSide(color: Colors.black, width: 2),
                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(4.0), topRight: Radius.circular(4.0)),
                                            ),
                                            errorBorder: const UnderlineInputBorder(
                                              borderSide: BorderSide(color: Colors.black, width: 2),
                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(4.0), topRight: Radius.circular(4.0)),
                                            ),
                                            focusedErrorBorder: const UnderlineInputBorder(
                                              borderSide: BorderSide(color: Colors.black, width: 2),
                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(4.0), topRight: Radius.circular(4.0)),
                                            ),
                                            contentPadding: const EdgeInsetsDirectional.fromSTEB(6, 6, 0, 6),
                                          ),
                                          style: TextStyle(fontSize: 16, fontFamily: GoogleFonts.manrope.toString(), color: Colors.black),
                                          //validator: ,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                                      child: Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.end, children: [
                                        Padding(
                                          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 4, 0),
                                          child: FloatingActionButton.extended(
                                              onPressed: () async {
                                                widget.passedGroup.idList.add(securityCodeController.text);
                                                try {
                                                  final provider = Provider.of<UserDataProvider>(context, listen: false);

                                                  CollectionReference users = FirebaseFirestore.instance.collection('User');
                                                  // Add the user data to Firestore
                                                  await users
                                                      .doc(provider.userData!.securityCode)
                                                      .collection('group')
                                                      .doc(widget.passedGroup.groupId)
                                                      .update({'id_list': widget.passedGroup.idList})
                                                      .then((value) => const SnackBar(content: Text('Data added')))
                                                      .catchError((error) => SnackBar(content: Text('Error: $error')));

                                                  // Clear the form fields
                                                  securityCodeController.clear();
                                                } on FirebaseException catch (e) {
                                                  showToast(e.toString(), error: true);
                                                }
                                                Navigator.pop(context);
                                                //nextPage(GroupViewWidget(passedGroup: widget.passedGroup), context);
                                              },
                                              label: const Text("Add Member")),
                                        ),
                                      ]),
                                    ),
                                  ]),
                            ),
                          ),
                        ]),
                      ),
                    )),
              ]),
            ),
          )),
    );
  }
}
