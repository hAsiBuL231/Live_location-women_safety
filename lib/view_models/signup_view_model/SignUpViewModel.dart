//SignUpViewModel

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_track_live/repository/login_repository/LoginRepository.dart';
import 'package:flutter_track_live/view/home_page_view/HomePage.dart';
import 'package:flutter_track_live/view/splash_screen.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../.utils/Functions.dart';

class SignUpViewModel extends GetxController {
  final _api = LoginRepository();

  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final confirmPasswordController = TextEditingController().obs;

  final emailFocusNode = FocusNode().obs;
  final passwordFocusNode = FocusNode().obs;
  final confirmPasswordFocusNode = FocusNode().obs;

  RxBool passwordVisibility1 = false.obs;
  RxBool passwordVisibility2 = false.obs;

  RxBool loading = false.obs;

  Future<void> signUpApi(context) async {
    loading.value = true;
    Map data = {
      'email': emailController.value.text,
      'password': passwordController.value.text,
    };
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: data['email'], password: data['password']);
    } on FirebaseAuthException catch (e) {
      showToast(e.message!, error: true);
    }

    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      showToast('User is Signed in!');
      Get.delete<SignUpViewModel>();
      //Get.to(const HomePageWidget());
      nextPage(const SplashScreen(), context);
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

}
