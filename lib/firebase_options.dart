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
    apiKey: 'AIzaSyCNcoAoQ2YyqDTlvmXdWy3dFxmeF52pB70',
    appId: '1:22688990554:android:14f172878ea8bd0ef11f63',
    messagingSenderId: '22688990554',
    projectId: 'estufainteligente-4ac45',
    databaseURL: 'https://estufainteligente-4ac45-default-rtdb.firebaseio.com',
    storageBucket: 'estufainteligente-4ac45.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC5Eqg3KnodiEB_oa6MRGSGuYde9JV1A9E',
    appId: '1:22688990554:ios:2fcf9d8063d4a8a4f11f63',
    messagingSenderId: '22688990554',
    projectId: 'estufainteligente-4ac45',
    databaseURL: 'https://estufainteligente-4ac45-default-rtdb.firebaseio.com',
    storageBucket: 'estufainteligente-4ac45.appspot.com',
    iosClientId: '22688990554-06hn8gd7vsmtjjcdgtepgv2cii1tk10f.apps.googleusercontent.com',
    iosBundleId: 'com.example.estufaInteligente',
  );
}