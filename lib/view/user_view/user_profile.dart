import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_track_live/.data/network/network_api_services.dart';
import 'package:flutter_track_live/components/text.dart';

import '../../.resources/app_url/AppUrl.dart';
import '../../models/user_models.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  //NetworkApiServices url = NetworkApiServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User List')),
      body: FutureBuilder(
        future: NetworkApiServices().getApi(AppUrl.userCollectionUrl),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
          //if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

          /// /////////////////////////////////// Finding the user data   //////////////////////////////
          String? userEmail = FirebaseAuth.instance.currentUser!.email;
          var response = snapshot.data['documents'];
          var users = response.map((doc) => Users.fromJson(doc));
          var matchedUsers = users.where((users) => users.email == userEmail).toList();

          /// /////////////////////////////////// Finding the user data   //////////////////////////////

          return Padding(
            padding: const EdgeInsets.all(14),
            child: ListView.builder(
              itemCount: matchedUsers.length,
              itemBuilder: (context, index) {
                Users user = Users.fromJson(response[index]);
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.all(3),
                  child: ListTile(
                    title: Text('Name: ${matchedUsers[index].securityCode}'),
                    subtitle: Text('Email: ${matchedUsers[index].email} \nCreated: ${matchedUsers[index].createTime.toString()}'),
                  ),
                );
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.all(3),
                  child: Column(children: [
                    customText(text: user.securityCode),
                    customText(text: user.email),
                  ]),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
