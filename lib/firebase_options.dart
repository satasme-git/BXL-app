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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyC_GtPJ7usQYBW8QB2W-e3pr9AJI-_w2kg',
    appId: '1:281033233479:web:aa38b74d78e245530e0d62',
    messagingSenderId: '281033233479',
    projectId: 'brew-crew-ec601',
    authDomain: 'brew-crew-ec601.firebaseapp.com',
    storageBucket: 'brew-crew-ec601.appspot.com',
    measurementId: 'G-YMMWP1Q62V',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA3HozYqCWoJaBOERRhAzTiYyndkZHM_kc',
    appId: '1:281033233479:android:ad262dfdab8a44910e0d62',
    messagingSenderId: '281033233479',
    projectId: 'brew-crew-ec601',
    storageBucket: 'brew-crew-ec601.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBp5VYf6TKD8xlQl3ZgCB5eKs5pZenwZ9I',
    appId: '1:281033233479:ios:a2dd45b35b405f0d0e0d62',
    messagingSenderId: '281033233479',
    projectId: 'brew-crew-ec601',
    storageBucket: 'brew-crew-ec601.appspot.com',
    androidClientId:
        '281033233479-jnn7brphu03e0gvrpqjl027luprsv7fe.apps.googleusercontent.com',
    iosClientId:
        '281033233479-7onhte57c3lt2ji41if7p5i2p3rdf42e.apps.googleusercontent.com',
    iosBundleId: 'com.satasme.binaryApp',
  );
}
