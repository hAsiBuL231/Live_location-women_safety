import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_track_live/view/splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '.data/user_data_SharedPreferences/app_user_data.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    //await FirebaseAppCheck.instance.activate(androidProvider: AndroidProvider.playIntegrity);
  } catch (e) {
    print(' \n \n \n Firebase initialization Error: \n $e  \n \n \n ');
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    /*return MaterialApp(
      title: 'Location Tracker',
      theme: ThemeData(
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        fontFamily: GoogleFonts.outfit().fontFamily,
        textTheme: const TextTheme(titleMedium: TextStyle(color: Colors.black)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: user == null ? const LoginPageView() : const HomePageWidget(),
    );*/

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => UserDataProvider()),
          //ChangeNotifierProvider(create: (context) => SmsProvider()),
        ],
        child: MaterialApp(
          title: 'Location Tracker',
          theme: ThemeData(
            //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            fontFamily: GoogleFonts.outfit().fontFamily,
            textTheme: const TextTheme(titleMedium: TextStyle(color: Colors.black)),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
          //home: user == null ? const LoginPageView() : const HomePageWidget(),
          /*home: user == null
              ? const LoginPageView()
              : user?.displayName == null
                  ? UserForm()
                  : const HomePageWidget(),*/
        ));
  }
}
