import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyA9MhbdtxZt92HUqT_2jlDSdUw3rFfPIbI",
            authDomain: "fricasse-sb3fj7.firebaseapp.com",
            projectId: "fricasse-sb3fj7",
            storageBucket: "fricasse-sb3fj7.firebasestorage.app",
            messagingSenderId: "584176998095",
            appId: "1:584176998095:web:f872c69b03cf7f5fcb49ba"));
  } else {
    await Firebase.initializeApp();
  }
}
