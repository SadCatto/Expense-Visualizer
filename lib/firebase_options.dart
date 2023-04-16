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
    apiKey: 'AIzaSyDkbEyOYv_pIgtj_3Bu-aI_UaEPXhtGO3E',
    appId: '1:623923278908:web:9efde57d015bd2f4dc7f39',
    messagingSenderId: '623923278908',
    projectId: 'expense-visualizer-69',
    authDomain: 'expense-visualizer-69.firebaseapp.com',
    storageBucket: 'expense-visualizer-69.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD-lOEkDtRQBkJqAFnov-FXuuYT9bqP4HE',
    appId: '1:623923278908:android:f6aa6856db924994dc7f39',
    messagingSenderId: '623923278908',
    projectId: 'expense-visualizer-69',
    storageBucket: 'expense-visualizer-69.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC_P4VCBh7xI0fX-rIuYfAjRSdfoR17Z3s',
    appId: '1:623923278908:ios:925bdd96fb8a9934dc7f39',
    messagingSenderId: '623923278908',
    projectId: 'expense-visualizer-69',
    storageBucket: 'expense-visualizer-69.appspot.com',
    iosClientId: '623923278908-rn8dc7irdtt6en2n0kih5amnbhc1e799.apps.googleusercontent.com',
    iosBundleId: 'com.expensetracker.expenseTracker',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC_P4VCBh7xI0fX-rIuYfAjRSdfoR17Z3s',
    appId: '1:623923278908:ios:925bdd96fb8a9934dc7f39',
    messagingSenderId: '623923278908',
    projectId: 'expense-visualizer-69',
    storageBucket: 'expense-visualizer-69.appspot.com',
    iosClientId: '623923278908-rn8dc7irdtt6en2n0kih5amnbhc1e799.apps.googleusercontent.com',
    iosBundleId: 'com.expensetracker.expenseTracker',
  );
}
