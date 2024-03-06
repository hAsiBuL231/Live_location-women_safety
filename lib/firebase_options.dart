// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCTicu2FlOCyetL_0obVMSiRP7Z5o06Y7k',
    appId: '1:441144425910:web:db506fabc5ef28dbbc1517',
    messagingSenderId: '441144425910',
    projectId: 'track-live-ac5dc',
    authDomain: 'track-live-ac5dc.firebaseapp.com',
    storageBucket: 'track-live-ac5dc.appspot.com',
    measurementId: 'G-VG2KXX94K0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA-3x35ohbievcepoc9RCFudSIYgyc8BII',
    appId: '1:441144425910:android:e1d8e41a2b437193bc1517',
    messagingSenderId: '441144425910',
    projectId: 'track-live-ac5dc',
    storageBucket: 'track-live-ac5dc.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBHxuftoH92gCKykfTtk4qij4Bhx9uT1_Y',
    appId: '1:441144425910:ios:544aaa64c268c2b7bc1517',
    messagingSenderId: '441144425910',
    projectId: 'track-live-ac5dc',
    storageBucket: 'track-live-ac5dc.appspot.com',
    androidClientId: '441144425910-2hgrdro67d25qmnn03luf27trndoec2j.apps.googleusercontent.com',
    iosClientId: '441144425910-pk96c6i5cirae11u5uncavamko9qu1td.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterTrackLive',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBHxuftoH92gCKykfTtk4qij4Bhx9uT1_Y',
    appId: '1:441144425910:ios:7000988c42952bfebc1517',
    messagingSenderId: '441144425910',
    projectId: 'track-live-ac5dc',
    storageBucket: 'track-live-ac5dc.appspot.com',
    androidClientId: '441144425910-2hgrdro67d25qmnn03luf27trndoec2j.apps.googleusercontent.com',
    iosClientId: '441144425910-fkbaikdshoro4h022fo05dpg2ambj192.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterTrackLive.RunnerTests',
  );
}
