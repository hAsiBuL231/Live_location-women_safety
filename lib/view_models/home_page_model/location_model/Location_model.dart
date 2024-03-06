import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';

import '../../../.utils/Functions.dart';

class LocationModel extends GetxController {
  Position currentPosition = Position(
      longitude: 98, latitude: 98, timestamp: DateTime.now(), accuracy: 1, altitude: 1, altitudeAccuracy: 1, heading: 2, headingAccuracy: 2, speed: 2, speedAccuracy: 2);
  RxString currentAddress = "".obs;
  LocationPermission permission = LocationPermission.whileInUse;

  getCurrentLocation(context) async {
    final hasPermission = await handleLocationPermission(context);
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high, forceAndroidLocationManager: true).then((Position position) {
      //setState(() {
      currentPosition = position;
      print(" \n \n currentPosition; $currentPosition \n \n ");
      getAddressFromLatLon();
      //});
    }).catchError((e) {
      showToast("getCurrentLocation: ${e.toString()}");
      //Fluttertoast.showToast(msg: e.toString());
    });
  }

  getAddressFromLatLon() async {
    try {
      List<Placemark> placeMarks = await placemarkFromCoordinates(currentPosition.latitude, currentPosition.longitude);

      Placemark place = placeMarks[0];
      currentAddress.value = "${place.locality},${place.postalCode},${place.street},";
    } catch (e) {
      showToast("getAddressFromLatLon: ${e.toString()}", error: true);
      //Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<bool> handleLocationPermission(context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showToast("Location services are disabled. Please enable the services", error: true);
      //ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showToast("Location permissions are denied", error: true);
        //ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      showToast("Location permissions are permanently denied, we cannot request permissions.", error: true);
      //ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    showToast("Location services are enabled");
    return true;
  }
}
