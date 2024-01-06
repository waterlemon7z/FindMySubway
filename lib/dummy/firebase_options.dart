// // ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
// import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
// import 'package:flutter/foundation.dart'
//     show defaultTargetPlatform, kIsWeb, TargetPlatform;
//
// /// Default [FirebaseOptions] for use with your Firebase apps.
// ///
// /// Example:
// /// ```dart
// /// import 'firebase_options.dart';
// /// // ...
// /// await Firebase.initializeApp(
// ///   options: DefaultFirebaseOptions.currentPlatform,
// /// );
// /// ```
// class DefaultFirebaseOptions {
//   static FirebaseOptions get currentPlatform {
//     if (kIsWeb) {
//       return web;
//     }
//     switch (defaultTargetPlatform) {
//       case TargetPlatform.android:
//         return android;
//       case TargetPlatform.iOS:
//         return ios;
//       case TargetPlatform.macOS:
//         throw UnsupportedError(
//           'DefaultFirebaseOptions have not been configured for macos - '
//           'you can reconfigure this by running the FlutterFire CLI again.',
//         );
//       case TargetPlatform.windows:
//         throw UnsupportedError(
//           'DefaultFirebaseOptions have not been configured for windows - '
//           'you can reconfigure this by running the FlutterFire CLI again.',
//         );
//       case TargetPlatform.linux:
//         throw UnsupportedError(
//           'DefaultFirebaseOptions have not been configured for linux - '
//           'you can reconfigure this by running the FlutterFire CLI again.',
//         );
//       default:
//         throw UnsupportedError(
//           'DefaultFirebaseOptions are not supported for this platform.',
//         );
//     }
//   }
//
//   static const FirebaseOptions web = FirebaseOptions(
//     apiKey: 'AIzaSyDCgHZueIKAp-YUmjTpVDW1CcTtCj6vhJY',
//     appId: '1:103768617122:web:8d1577f24ca32c5fcde7fb',
//     messagingSenderId: '103768617122',
//     projectId: 'findmysubway',
//     authDomain: 'findmysubway.firebaseapp.com',
//     storageBucket: 'findmysubway.appspot.com',
//     measurementId: 'G-J0EXP1MNRX',
//   );
//
//   static const FirebaseOptions android = FirebaseOptions(
//     apiKey: 'AIzaSyCrG1i0LS6tNSzNS7_EDLI21uPZYnDk5fc',
//     appId: '1:103768617122:android:2639fa2271af031acde7fb',
//     messagingSenderId: '103768617122',
//     projectId: 'findmysubway',
//     storageBucket: 'findmysubway.appspot.com',
//   );
//
//   static const FirebaseOptions ios = FirebaseOptions(
//     apiKey: 'AIzaSyBBURXg1buqHd6ZMPlDSMNQnWFWHHiaHH4',
//     appId: '1:103768617122:ios:b184cfaff02f2a45cde7fb',
//     messagingSenderId: '103768617122',
//     projectId: 'findmysubway',
//     storageBucket: 'findmysubway.appspot.com',
//     iosClientId: '103768617122-tcfvqh8ik2at9j3pf477tv6p2e3rvshi.apps.googleusercontent.com',
//     iosBundleId: 'com.lemon7z.findMySubway',
//   );
// }
