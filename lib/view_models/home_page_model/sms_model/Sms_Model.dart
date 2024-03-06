import 'package:flutter/material.dart';
import 'package:background_sms/background_sms.dart';
import 'package:flutter_track_live/.utils/Functions.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shake/shake.dart';
import 'ContactModel.dart';
import '../location_model/Location_model.dart';
import 'package:permission_handler/permission_handler.dart';

class SmsModel extends GetxController {
  //final locationProvider = Provider.of<LocationProvider>(context as BuildContext, listen: false);
  //final homePageVM = Get.put(HomePageModel());
  //final locationVM = Get.put(LocationModel());

  isPermissionGranted() async => await Permission.sms.status.isGranted;

  requestSMSPermission() async {
    var status = await Permission.sms.status;
    if (status.isDenied) {
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
      await Permission.sms.request();
    }
  }

  void shakeInitialization() {
    ShakeDetector.autoStart(
      onPhoneShake: () {
        getAndSendSMS();
        //ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Shake!')));
        Get.snackbar("Shake", "Shake");
        // Do stuff on phone shake
      },
      minimumShakeCount: 1,
      shakeSlopTimeMS: 500,
      shakeCountResetTime: 3000,
      shakeThresholdGravity: 2.7,
    );
    // To close: detector.stopListening();
    // ShakeDetector.waitForStart() waits for user to call detector.startListening();
  }

  void sendSms(String phoneNumber, String message, {int? simSlot}) async {
    //SmsStatus result = await BackgroundSms.sendMessage(phoneNumber: phoneNumber, message: message, simSlot: 2);
    bool? result1 = await BackgroundSms.isSupportCustomSim;
    if (result1 == true) {
      showToast("Support Custom Sim Slot");
      SmsStatus result = await BackgroundSms.sendMessage(phoneNumber: phoneNumber, message: message, simSlot: simSlot);
      if (result == SmsStatus.sent) {
        Fluttertoast.showToast(msg: "SMS send");
      } else {
        Fluttertoast.showToast(msg: "SMS send failed", backgroundColor: Colors.red);
      }
    } else {
      showToast("Not Support Custom Sim Slot", error: true);
    }

    //notifyListeners();
  }

  getAndSendSMS() async {
    String recipients = "";
    //List<TContact> contactList = await DatabaseHelper().getContactList();
    List<ContactModel> contactList = [ContactModel('01811989292', 'Hasib')];
    print(contactList.length);
    if (contactList.isEmpty) {
      Fluttertoast.showToast(msg: "Emergency contact is empty");
    } else {
      //Fluttertoast.showToast(msg: "Emergency contact");

      Position? currentPosition;
      await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high, forceAndroidLocationManager: true).then((Position position) {
        currentPosition = position;
        showToast("CurrentPosition: ${currentPosition.toString()}");
      }).catchError((e) {
        showToast("CurrentLocation Error: ${e.toString()}", error: true);
      });

      List<Placemark> placeMarks = await placemarkFromCoordinates(currentPosition!.latitude, currentPosition!.longitude);

      Placemark place = placeMarks[0];
      String currentAddress = "Locality: ${place.locality}, Postal Code${place.postalCode}, Street: ${place.street}";

      //showToast("_curentPosition: ${_curentPosition.latitude}%2C${_curentPosition.longitude} . _curentAddress: $_curentAddress");
      String messageBody =
          "https://www.google.com/maps/search/?api=AIzaSyC_WdqkLQKoxjnUSUVgErrLoecARk430Z4&query=${currentPosition!.latitude}%2C${currentPosition!.longitude} . $currentAddress";

      showToast(messageBody);

      requestSMSPermission();
      if (await isPermissionGranted()) {
        for (var element in contactList) {
          sendSms(element.number, "i am in trouble $messageBody");
        }
      } else {
        showToast("SMS permission is not granted", error: true);
        //Fluttertoast.showToast(msg: "SMS permission is not granted");
      }
    }
    //notifyListeners();
  }
}
