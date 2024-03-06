import 'package:flutter/material.dart';
import 'package:flutter_track_live/.utils/utils.dart';
import 'package:get/get.dart';

import 'package:flutter_track_live/view_models/login_view_model/LoginViewModel.dart';
import '../../.utils/Functions.dart';

class LoginPageView extends StatefulWidget {
  const LoginPageView({super.key});

  @override
  State<LoginPageView> createState() => _LoginPageViewState();
}

class _LoginPageViewState extends State<LoginPageView> {
  final loginVM = Get.put(LoginViewModel());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: Image.asset("Assets/images/maps.jpg").image,
                /*image: Image.network(
                  'https://images.unsplash.com/photo-1604357209793-fca5dca89f97?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxfHxtYXB8ZW58MHx8fHwxNzA3OTA5NjQyfDA&ixlib=rb-4.0.3&q=80&w=1080',
                ).image,*/
                opacity: 0.7,
                fit: BoxFit.cover)),
        child: SafeArea(
            child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 110, bottom: 20, right: 25, left: 25),
            child: Column(children: [
              const Text("Welcome Back!\nLogin", textAlign: TextAlign.center, style: TextStyle(fontSize: 34, color: Colors.white, fontFamily: "Raleway", height: 1.2)),
              TextButton(
                  //onPressed: () => nextPage(const SignUpPage(), context),
                  style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blue)),
                  onPressed: () {},
                  child: const Text("New User? Register", style: TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold, fontFamily: 'OpenSans'))),
              const SizedBox(height: 40),
              Form(
                key: _formKey,
                child: Column(children: [
                  TextFormField(
                      controller: loginVM.emailController.value,
                      focusNode: loginVM.emailFocusNode.value,
                      validator: (value) {
                        /*if (value!.contains('@gmail.com')) {
                          return null;
                        }*/
                        if (value!.isEmail) {
                          return null;
                        }
                        return 'Please enter a valid Gmail!';
                      },
                      //onChanged: (value) => _email = value,
                      onFieldSubmitted: (value) => Utils.fieldFocusChange(context, loginVM.emailFocusNode.value, loginVM.passwordFocusNode.value),
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.mail, color: Colors.white),
                          hintText: 'Email',
                          labelText: 'Email',
                          fillColor: Colors.white70,
                          filled: true,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)))),
                  const SizedBox(height: 20),
                  TextFormField(
                      controller: loginVM.passwordController.value,
                      focusNode: loginVM.passwordFocusNode.value,
                      validator: (input) {
                        if (input!.length < 6) {
                          return 'Your password needs to be at least 6 character';
                        }
                        return null;
                      },
                      obscureText: true,
                      //onChanged: (value) => _password = value,
                      onFieldSubmitted: (value) {
                        if (_formKey.currentState!.validate()) {
                          loginVM.loginApi(context);
                        }
                      },
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.vpn_key, color: Colors.white),
                          hintText: 'Password',
                          labelText: 'Password',
                          fillColor: Colors.white70,
                          filled: true,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)))),
                ]),
              ),
              TextButton(
                  //onPressed: () => nextPage(const ForgetPasswordPage(), context),
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.transparent),
                      textStyle: MaterialStatePropertyAll(TextStyle(decoration: TextDecoration.underline))),
                  onPressed: () {},
                  child: const Text("Forgot Password?", style: TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'OpenSans'))),
              const SizedBox(height: 40),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                const Text("Sign In", style: TextStyle(color: Colors.white, fontSize: 32, fontFamily: "Raleway")),
                if (loginVM.loading.isFalse)
                  FloatingActionButton(
                      child: const Icon(Icons.arrow_forward),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) loginVM.loginApi(context);
                      })
                else
                  const CircularProgressIndicator(),
                /*Obx(() {
                  if (loginVM.loading.isFalse) {
                    return FloatingActionButton(
                        child: const Icon(Icons.arrow_forward),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) loginVM.loginApi();
                        });
                  } else {
                    return const CircularProgressIndicator();
                  }
                })*/
              ]),
              const SizedBox(height: 20),
              FloatingActionButton.extended(
                  onPressed: () async {
                    loginVM.googleLoginApi(context);
                  },
                  //icon: Image.asset('images/google_logo.png', height: 28, width: 28),
                  icon: const Icon(Icons.g_mobiledata, size: 60),
                  label: const Text('Sign in with Google'),
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white),
              const SizedBox(height: 20),
            ]),
          ),
        )));
  }
}
