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
    apiKey: 'AIzaSyBUmlfJzyYWxMTNpOQaKVKrC5fubqs9Kfs',
    appId: '1:370823621311:web:9ddd4278595d0f224a340a',
    messagingSenderId: '370823621311',
    projectId: 'ecoalerta-lapaz',
    authDomain: 'ecoalerta-lapaz.firebaseapp.com',
    storageBucket: 'ecoalerta-lapaz.appspot.com',
    measurementId: 'G-FVPPHG69J8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB0F3sLjk88Glpqx52-Ym3SZlwiA6F0eys',
    appId: '1:370823621311:android:9c9a6dc33e32f0dc4a340a',
    messagingSenderId: '370823621311',
    projectId: 'ecoalerta-lapaz',
    storageBucket: 'ecoalerta-lapaz.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAPTgxgfDmp4RxlHr9CYC00WLm84SarMsU',
    appId: '1:370823621311:ios:e175c706ef68ecb04a340a',
    messagingSenderId: '370823621311',
    projectId: 'ecoalerta-lapaz',
    storageBucket: 'ecoalerta-lapaz.appspot.com',
    iosBundleId: 'com.example.ecoalertaLapaz',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAPTgxgfDmp4RxlHr9CYC00WLm84SarMsU',
    appId: '1:370823621311:ios:3aea7124479cbf184a340a',
    messagingSenderId: '370823621311',
    projectId: 'ecoalerta-lapaz',
    storageBucket: 'ecoalerta-lapaz.appspot.com',
    iosBundleId: 'com.example.ecoalertaLapaz.RunnerTests',
  );
}