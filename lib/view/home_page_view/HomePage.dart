import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:background_sms/background_sms.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_track_live/.data/user_data_SharedPreferences/app_user_data.dart';
import 'package:flutter_track_live/.utils/Functions.dart';
import 'package:flutter_track_live/view/home_page_view/widgets/radio_button_widget.dart';
import 'package:flutter_track_live/view/home_page_view/widgets/security_code_widget.dart';
import 'package:flutter_track_live/view/user_view/user_profile.dart';
import 'package:flutter_track_live/view_models/home_page_model/HomePageModel.dart';
import 'package:flutter_track_live/view_models/home_page_model/sms_model/Sms_Model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shake/shake.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../.data/network/network_api_services.dart';
import '../../.resources/colours/app_colours.dart';
import '../../components/drawer.dart';
import '../../models/user_models.dart';
import '../../view_models/home_page_model/location_model/Location_model.dart';
import '../forms/UserForm.dart';
import 'widgets/group_list_widget.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

//class _HomePageWidgetState extends State<HomePageWidget> with TickerProviderStateMixin {

class _HomePageWidgetState extends State<HomePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final smsVm = Get.put(SmsModel());
  final locationVM = Get.put(LocationModel());

  @override
  void initState() {
    super.initState();
    //WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));

    //final locationProvider = Provider.of<LocationProvider>(context, listen: false);
    //final smsProvider = Provider.of<SmsProvider>(context, listen: false);

    //shared_Preferences().saveName('Hasibul Hossain');
    //shared_Preferences().loadName().then((value) => name = value);
    ShakeDetector.autoStart(
      onPhoneShake: () async {
        showToast("Shake! Shake!");
        Get.snackbar("Shake", "Shake");

        await Geolocator.requestPermission();
        await Permission.sms.request();

        smsVm.getAndSendSMS();
        //ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Shake!')));
        // Do stuff on phone shake
      },
      minimumShakeCount: 1,
      shakeSlopTimeMS: 500,
      shakeCountResetTime: 3000,
      shakeThresholdGravity: 2.7,
    );
  }

  Future<void> _refreshData() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    //shared_Preferences().loadName().then((value) => name = value);
    //var userDataProvider = Provider.of<UserDataProvider>(context);

    return SafeArea(
      child: Scaffold(
        drawer: const DrawerWidget(),
        key: scaffoldKey,
        backgroundColor: AppColours.primaryBackground,
        body: Padding(
          padding: const EdgeInsets.all(6),
          child: RefreshIndicator(
            onRefresh: _refreshData,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, children: [
                const SizedBox(height: 30),

                /// /////////////////////////// Enable Live Location   ///////////////////////////

                Padding(
                  padding: const EdgeInsets.all(10),
                  child: radioButton(context),
                ),
                const SizedBox(height: 0),

                /// ///////////////////////////    Your security code   ///////////////////////////

                securityCodeView,

                /// ///////////////////////////    Create new Group   ///////////////////////////

                groupListWidget(context),
                const SizedBox(height: 20),

                /// ///////////////////////////    Next Button   ///////////////////////////

                /*ElevatedButton(onPressed: () => nextPage(const UserProfile(), context), child: const Text("Next Page")),
                const SizedBox(height: 20),*/

                /// ///////////////////////////    User Data   ///////////////////////////

                /*Text("Shared name: $name"),
                const SizedBox(height: 20),

                ///

                Selector<UserDataProvider, Users?>(
                    selector: (_, provider) => provider.userData?.userData,
                    builder: (_, userData, __) {
                      return Text('Stored Data: ${userData!.name}');
                    }),*/

                /// ///////////////////////////    End   ///////////////////////////
                const SizedBox(height: 30),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
