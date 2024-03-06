import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_track_live/.resources/app_url/AppUrl.dart';
import 'package:get/get.dart';
import 'package:location/location.dart' as loc;
import 'package:provider/provider.dart';

import '../../../.data/network/network_api_services.dart';
import '../../../.data/user_data_SharedPreferences/app_user_data.dart';
import '../../../models/user_models.dart';

class ListenLocationProvider extends GetxController {
  final loc.Location location = loc.Location();
  StreamSubscription<loc.LocationData>? _locationSubscription;

  String userEmail = FirebaseAuth.instance.currentUser!.email!;

  Future<void> listenLocation(BuildContext context) async {
    _locationSubscription = location.onLocationChanged.handleError((onError) {
      print(" \n \n \n _listenLocation Error: \n $onError \n \n \n ");
      //print(onError);
      _locationSubscription?.cancel();
      //setState(() => _locationSubscription = null);
      _locationSubscription = null;
    }).listen((loc.LocationData currentLocation) async {
      final userProvider = Provider.of<UserDataProvider>(context, listen: false);

      //Users? user;

      /// /////////////////////////////////// Finding the user data   //////////////////////////////
      /*var provider = Provider.of<UserDataProvider>(context, listen: false);
      await NetworkApiServices().getApi(AppUrl.userCollectionUrl).then((value) {
        String? userEmail = FirebaseAuth.instance.currentUser!.email;
        var response = value['documents'];
        var users = response.map((doc) => Users.fromJson(doc));
        var matchedUsers = users.where((users) => users.email == userEmail).toList();
        user = matchedUsers[0];
        print(" \n \n Print2: ${user!.securityCode} \n \n ");
      });*/

      /// /////////////////////////////////// Finding the user data   //////////////////////////////
      //if (user != null) {
      await FirebaseFirestore.instance.collection('User').doc(userProvider.userData!.securityCode).collection('location').doc('lat-long').set({
        'latitude': currentLocation.latitude,
        'longitude': currentLocation.longitude,
        //'Location': currentLocation,
      }, SetOptions(merge: true));
      //}
      //showToast('_listenLocation Successful');
    });
  }

  stopListening() {
    _locationSubscription?.cancel();
    //setState(() => _locationSubscription = null);
    _locationSubscription = null;
  }
}
