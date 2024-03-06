import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_track_live/.utils/Functions.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../view_models/home_page_model/HomePageModel.dart';
import 'forms/UserForm.dart';
import 'home_page_view/HomePage.dart';
import 'login_view/LoginPageView.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _progressValue = 0.0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    final homePageVM = Get.put(HomePageModel());

    String? userName = FirebaseAuth.instance.currentUser?.displayName;
    if (userName != null) {
      homePageVM.loadData(context).then((value) {
        _startTimer();
      });
    } else {
      _startTimer();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        setState(() {
          if (_progressValue == 1.0) {
            timer.cancel();
            _timer?.cancel();
            User? user = FirebaseAuth.instance.currentUser;
            if (user == null) {
              print('User is currently signed out!');
              newPage(const LoginPageView(), context);
              //Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPageView()));
            } else {
              print('User is logged in!');
              if (user.displayName != null) {
                showToast('Welcome Back, ${user.displayName}!');
                newPage(const HomePageWidget(), context);
                //Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePageWidget()));
              } else {
                nextPage(UserForm(), context);
              }
            }
          } else {
            _progressValue += 0.2;
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: Image.asset("Assets/images/maps.jpg").image,
                /*image: Image.network(
                  'https://images.unsplash.com/photo-1604357209793-fca5dca89f97?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxfHxtYXB8ZW58MHx8fHwxNzA3OTA5NjQyfDA&ixlib=rb-4.0.3&q=80&w=1080',
                ).image,*/
                opacity: 1,
                fit: BoxFit.cover)),
        child: Stack(children: [
          Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.8),
              Text("Loading Data...", style: TextStyle(color: Colors.white, fontSize: 20, fontStyle: FontStyle.italic, fontFamily: GoogleFonts.aboreto.toString())),
              //const CircularProgressIndicator(color: Colors.white),
              const SizedBox(height: 4),
              SizedBox(width: MediaQuery.of(context).size.width * 0.7, child: const LinearProgressIndicator(color: Colors.white, minHeight: 5))
            ]),
          )
          /*Image.network(
            'https://images.unsplash.com/photo-1604357209793-fca5dca89f97?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxfHxtYXB8ZW58MHx8fHwxNzA3OTA5NjQyfDA&ixlib=rb-4.0.3&q=80&w=1080',
          )*/
        ]),
      ),
    );
  }
}
