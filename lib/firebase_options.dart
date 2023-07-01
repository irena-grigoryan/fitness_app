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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDIsW2h86mIrfornh7Y7Bwqke1Sm5PJ6jQ',
    appId: '1:1090088400371:android:1ed6a240111697ea5ece86',
    messagingSenderId: '1090088400371',
    projectId: 'fitness-app-531de',
    storageBucket: 'fitness-app-531de.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCmdVDH3j3-JYts12HlAq_FlyAHCjWL76I',
    appId: '1:1090088400371:ios:9e9f72dc82de43795ece86',
    messagingSenderId: '1090088400371',
    projectId: 'fitness-app-531de',
    databaseURL:
        'https://fitness-app-531de-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'fitness-app-531de.appspot.com',
    iosClientId:
        '1090088400371-57qs76nkvnro3ed18oa6p43c8op5ngdq.apps.googleusercontent.com',
    iosBundleId: 'com.example.fitnessapp1',
  );
}