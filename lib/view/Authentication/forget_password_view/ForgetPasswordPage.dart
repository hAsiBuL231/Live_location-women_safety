import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  String _email = '';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SignUpPage',
      home: Builder(
        builder: (context) => Container(
          decoration: BoxDecoration(image: DecorationImage(image: Image.asset("Assets/images/maps.jpg").image, fit: BoxFit.cover)),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 180, bottom: 20, right: 20, left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Reset\nPassword',
                      textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontFamily: 'Raleway', fontSize: 38, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 50),
                  Column(
                    children: [
                      TextFormField(
                          validator: (input) {
                            if (input == null && input!.contains('@gmail.com')) {
                              return 'Please enter a valid Gmail';
                            }
                            return null;
                          },
                          onChanged: (value) => _email = value,
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.email, color: Colors.white),
                              hintText: 'Email',
                              labelText: 'Email',
                              fillColor: Colors.white70,
                              filled: true,
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)))),
                    ],
                  ),
                  const SizedBox(height: 150),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                    const Text(
                      "Send Request",
                      style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    FloatingActionButton(
                        onPressed: () async {
                          await FirebaseAuth.instance.sendPasswordResetEmail(email: _email);
                        },
                        child: const Icon(Icons.arrow_forward))
                  ]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
