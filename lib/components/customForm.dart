import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomForm extends StatefulWidget {
  const CustomForm({super.key});

  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  TextEditingController projectNameController = TextEditingController();

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
                                                  'Create Group',
                                                  style: TextStyle(fontSize: 20, fontFamily: GoogleFonts.manrope.toString(), color: Colors.black),
                                                )),
                                            Padding(
                                                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                                                child: Text(
                                                  'Please enter the information below to create a group.',
                                                  style: TextStyle(fontSize: 12, fontFamily: GoogleFonts.manrope.toString(), color: Colors.black),
                                                )),
                                          ]),
                                        ),
                                        CloseButton(onPressed: () => Navigator.pop(context)),
                                      ]),
                                    ),
                                    Row(mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.start, children: [
                                      Expanded(
                                          child: Padding(
                                              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                                              child: Container(
                                                width: 120,
                                                height: 250,
                                                decoration: BoxDecoration(
                                                  color: Colors.black12,
                                                  borderRadius: BorderRadius.circular(16),
                                                ),
                                                child: Stack(alignment: const AlignmentDirectional(0, 0), children: [
                                                  Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
                                                    const Icon(Icons.add_a_photo_outlined, color: Colors.black, size: 72),
                                                    Padding(
                                                        padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                                                        child: Text(
                                                          'Add Photo',
                                                          style: TextStyle(fontSize: 20, fontFamily: GoogleFonts.manrope.toString(), color: Colors.white),
                                                        )),
                                                    Padding(
                                                        padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                                                        child: Text(
                                                          'Upload an image here...',
                                                          style: TextStyle(fontSize: 12, fontFamily: GoogleFonts.manrope.toString(), color: Colors.white),
                                                        )),
                                                  ]),
                                                  Padding(
                                                      padding: EdgeInsets.all(8),
                                                      child: InkWell(
                                                          onTap: () {},
                                                          splashColor: Colors.transparent,
                                                          focusColor: Colors.transparent,
                                                          hoverColor: Colors.transparent,
                                                          highlightColor: Colors.transparent,
                                                          child: ClipRRect(
                                                              borderRadius: BorderRadius.circular(10),
                                                              child: CachedNetworkImage(
                                                                fadeInDuration: Duration(milliseconds: 500),
                                                                fadeOutDuration: Duration(milliseconds: 500),
                                                                imageUrl: '',
                                                                width: double.infinity,
                                                                height: double.infinity,
                                                                fit: BoxFit.cover,
                                                                errorWidget: (context, url, error) => Container(),
                                                              )))),
                                                ]),
                                              ))),
                                    ]),
                                    Form(
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                                        child: TextFormField(
                                          onTap: () {},
                                          controller: projectNameController,
                                          //focusNode: _model.projectNameFocusNode,
                                          //autofocus: true,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            hintText: 'Group Name',
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
                                          child: FloatingActionButton.extended(onPressed: () {}, label: const Text("Create Group")),
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
