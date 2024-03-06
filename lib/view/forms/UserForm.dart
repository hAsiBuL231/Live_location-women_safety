import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_track_live/view/home_page_view/HomePage.dart';
import 'package:images_picker/images_picker.dart';

class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final GlobalKey<FormState> formKey5 = GlobalKey<FormState>();

  final userName = FirebaseAuth.instance.currentUser?.displayName;
  final userEmail = FirebaseAuth.instance.currentUser?.email;
  String? userImage = FirebaseAuth.instance.currentUser?.photoURL;

  String _message = 'Personal information saved successfully!';
  String error = '';

  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _batchController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _batchController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    //if (formKey5.currentState!.validate()) {
      try {
        CollectionReference users = FirebaseFirestore.instance.collection('users');
        DateTime now = DateTime.now();
        DateTime date = DateTime(now.year, now.month, now.day);
        // Add the user data to Firestore
        await users
            .doc('$userEmail')
            .set({
              'name': _nameController.text,
              'email': userEmail.toString(),
              'phone': _phoneController.text,
              'batch': _batchController.text,
              'joined': date,
            })
            .then((value) => SnackBar(content: Text('Data added')))
            .catchError((error) => SnackBar(content: Text('Error: $error')));

        FirebaseAuth.instance.currentUser!.updateDisplayName(_nameController.text);

        // Clear the form fields
        _nameController.clear();
        _phoneController.clear();
        _batchController.clear();
      } on FirebaseException catch (e) {
        setState(() {
          error = e.message.toString();
        });
      }

      // Show a success dialog
      showDialog(
          context: context,
          builder: (context) => AlertDialog(title: Text('Success'), content: Text('$_message'), actions: [
                TextButton(
                    onPressed: () {
                      //Navigator.of(context).pop();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePageWidget()));
                    },
                    child: Text('OK'))
              ]));
    //}
  }

  Future<void> _selectPhoto() async {
    List<Media>? pickedFile = await ImagesPicker.pick(count: 1, pickType: PickType.image);
    var image = pickedFile?.first;
    //final pickedFile =
    //    await ImagePicker().pickImage(source: ImageSource.gallery);
    //XFile image = await ImagePickerAndroid.pickImage(source: Images);

    if (pickedFile != null) {
      try {
        Reference ref = FirebaseStorage.instance.ref().child('profile.jpg');
        await ref.putString(image!.path);
        ref.getDownloadURL().then((value) {
          print(value);
          setState(() {
            FirebaseAuth.instance.currentUser?.updatePhotoURL(value);
            userImage = FirebaseAuth.instance.currentUser?.photoURL;
          });
        });
      } catch (e) {
        setState(() {
          error = e.toString();
        });
      }
    }
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
              TextButton(onPressed: () => _selectPhoto(), child: Text('Select Image')),
              SizedBox(height: 10.0),
              Text('$error'),
              TextFormField(
                  validator: (value) {
                    if (value == '')
                      return 'Please enter your Name!';
                    else
                      return null;
                  },
                  controller: _nameController,
                  decoration: InputDecoration(prefixIcon: Icon(Icons.account_circle, color: Colors.blue), labelText: 'Name', hintText: '$userName')),
              SizedBox(height: 16.0),
              TextFormField(
                validator: (value) {
                  if (value!.length < 11)
                    return 'Please enter a valid number!';
                  else
                    return null;
                },
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(labelText: 'Phone', prefixIcon: Icon(Icons.phone, color: Colors.blue)),
              ),
              SizedBox(height: 16.0),
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
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                child: Text('Submit', style: TextStyle(fontSize: 28, color: Colors.white)),
                onPressed: _submitForm,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
