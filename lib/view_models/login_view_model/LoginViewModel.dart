import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_track_live/repository/login_repository/LoginRepository.dart';
import 'package:flutter_track_live/view/home_page_view/HomePage.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../.utils/Functions.dart';

class LoginViewModel extends GetxController {
  final _api = LoginRepository();

  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;

  final emailFocusNode = FocusNode().obs;
  final passwordFocusNode = FocusNode().obs;

  RxBool loading = false.obs;

  Future<void> loginApi(context) async {
    loading.value = true;
    Map data = {
      'email': emailController.value.text,
      'password': passwordController.value.text,
    };
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: data['email'], password: data['password']);
    } on FirebaseAuthException catch (e) {
      showToast(e.message!);
    }

    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      showToast('User is Signed in!');
      Get.delete<LoginViewModel>();
      //Get.to(const HomePageWidget());
      nextPage(const HomePageWidget(), context);
    }
    loading.value = false;

    /*
    _api.loginApi(data).then((value) {
      loading.value = false;
      Utils.snackBar('Login', 'Login successful');
    }).onError((error, stackTrace) {
      loading.value = false;
      Utils.snackBar('Error', error.toString());
    });*/
  }

  googleLoginApi(context) async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return;
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      showToast(e.toString());
    }
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      print('User is Signed in!');
      //Get.to(const HomePageWidget());
      nextPage(const HomePageWidget(), context);
    }
  }
}
