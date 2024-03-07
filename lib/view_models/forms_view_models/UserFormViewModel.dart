import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_track_live/view/splash_screen.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../.utils/Functions.dart';

class UserFormViewModel extends GetxController {
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> phoneController = TextEditingController().obs;
  Rx<TextEditingController> batchController = TextEditingController().obs;

  final userName = FirebaseAuth.instance.currentUser?.displayName;
  final userEmail = FirebaseAuth.instance.currentUser?.email;
  String? userImage = FirebaseAuth.instance.currentUser?.photoURL;

  Future<void> submitForm(context) async {
    //if (formKey5.currentState!.validate()) {
    try {
      CollectionReference users = FirebaseFirestore.instance.collection('User');
      DateTime now = DateTime.now();
      DateTime date = DateTime(now.year, now.month, now.day);
      // Add the user data to Firestore
      await users
          .doc()
          .set({
            'name': nameController.value.text,
            'email': userEmail.toString(),
            'phone': phoneController.value.text,
            'imageUrl': userImage,
            'joined': date,
          })
          .then((value) => SnackBar(content: Text('Data added')))
          .catchError((error) => SnackBar(content: Text('Error: $error')));

      FirebaseAuth.instance.currentUser!.updateDisplayName(nameController.value.text);

      // Clear the form fields
      nameController.value.clear();
      phoneController.value.clear();
    } on FirebaseException catch (e) {
      showToast(e.toString(), error: true);
    }

    // Show a success dialog
    /*Get.dialog(AlertDialog(title: Text('Success'), content: Text('Personal information saved successfully!'), actions: [
      TextButton(
          onPressed: () {
            //Navigator.of(context).pop();
            Get.to(const SplashScreen());
            //Navigator.push(context, MaterialPageRoute(builder: (context) => SplashScreen()));
          },
          child: Text('OK'))
    ]));*/
    showDialog(
        context: context,
        builder: (context) => AlertDialog(title: Text('Success'), content: Text('Personal information saved successfully!'), actions: [
              TextButton(
                  onPressed: () {
                    //Navigator.of(context).pop();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SplashScreen()));
                  },
                  child: Text('OK'))
            ]));
  }

  Future<void> selectPhoto() async {
    //List<Media>? pickedFile = await ImagesPicker.pick(count: 1, pickType: PickType.image);
    //var image = pickedFile?.first;

    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    var image = pickedFile;
    //final pickedFile =
    //    await ImagePicker().pickImage(source: ImageSource.gallery);
    //XFile image = await ImagePickerAndroid.pickImage(source: Images);

    if (pickedFile != null) {
      try {
        Reference ref = FirebaseStorage.instance.ref().child('profile.jpg');
        await ref.putString(image!.path);
        ref.getDownloadURL().then((value) {
          print(value);
          FirebaseAuth.instance.currentUser?.updatePhotoURL(value);
          userImage = FirebaseAuth.instance.currentUser?.photoURL;
        });
      } catch (e) {
        showToast(e.toString(), error: true);
      }
    }
  }
}
