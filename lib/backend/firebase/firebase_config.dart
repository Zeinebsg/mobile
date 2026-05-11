import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBDvfCZUNPLe_DnLrbV0GVABSr0yzUhOsw",
            authDomain: "fricasse-4dv7jn.firebaseapp.com",
            projectId: "fricasse-4dv7jn",
            storageBucket: "fricasse-4dv7jn.firebasestorage.app",
            messagingSenderId: "971210585607",
            appId: "1:971210585607:web:fac8188dde186b7f855ca2"));
  } else {
    await Firebase.initializeApp();
  }
}
