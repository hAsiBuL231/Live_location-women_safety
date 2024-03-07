import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_track_live/.utils/Functions.dart';
import 'package:flutter_track_live/view/home_page_view/HomePage.dart';
import 'package:get/get.dart';
import '../../components/GetImage.dart';
import '../../view_models/forms_view_models/UserFormViewModel.dart';

class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final GlobalKey<FormState> formKey5 = GlobalKey<FormState>();

  final userName = FirebaseAuth.instance.currentUser?.displayName;
  final userEmail = FirebaseAuth.instance.currentUser?.email;
  String? userImage = FirebaseAuth.instance.currentUser?.photoURL;

  final userFormVM = Get.put(UserFormViewModel());

  @override
  void dispose() {
    userFormVM.nameController.value.dispose(); // userFormVM.nameController.value
    userFormVM.phoneController.value.dispose(); // userFormVM.phoneController.value
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Personal Information'), backgroundColor: Colors.blueAccent),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: formKey5,
          child: Column(
            children: [
              SizedBox(height: 16.0),
              CircleAvatar(radius: 80, backgroundImage: NetworkImage('$userImage')),
              TextButton(onPressed: () => nextPage(const GetImage(), context), child: Text('Select Image')),

              //TextButton(onPressed: () => userFormVM.selectPhoto(), child: Text('Select Image')),
              // SizedBox(height: 10.0),
              // Container(
              //     width: 90,
              //     height: 90,
              //     decoration: const BoxDecoration(shape: BoxShape.circle),
              //     child: Container(
              //       width: 80,
              //       height: 80,
              //       clipBehavior: Clip.antiAlias,
              //       decoration: const BoxDecoration(shape: BoxShape.circle),
              //       child: CircleAvatar(backgroundColor: Colors.deepPurpleAccent, child: CachedNetworkImage(imageUrl: '$userImage', fit: BoxFit.cover)),
              //     )),
              // const SizedBox(height: 20),
              // FloatingActionButton.extended(onPressed: () => nextPage(const GetImage(), context), label: const Text("Change Photo"), heroTag: 'tag1'),
              const SizedBox(height: 30),

              TextFormField(
                  validator: (value) {
                    if (value == '')
                      return 'Please enter your Name!';
                    else
                      return null;
                  },
                  controller: userFormVM.nameController.value,
                  decoration: InputDecoration(prefixIcon: Icon(Icons.account_circle, color: Colors.blue), labelText: 'Name', hintText: '$userName')),
              SizedBox(height: 16.0),
              TextFormField(
                validator: (value) {
                  if (value!.length < 11)
                    return 'Please enter a valid number!';
                  else
                    return null;
                },
                controller: userFormVM.phoneController.value,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(labelText: 'Phone', prefixIcon: Icon(Icons.phone, color: Colors.blue)),
              ),
              /*SizedBox(height: 16.0),
              TextFormField(
                validator: (value) {
                  if (value == '')
                    return 'Please enter your Batch!';
                  else
                    return null;
                },
                controller: _batchController,
                keyboardType: TextInputType.streetAddress,
                decoration: InputDecoration(labelText: 'Your Batch', prefixIcon: Icon(Icons.location_on, color: Colors.blue)),
              ),*/
              SizedBox(height: 32.0),
              ElevatedButton(
                child: Text('Submit', style: TextStyle(fontSize: 28, color: Colors.black)),
                onPressed: () => userFormVM.submitForm(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
