import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCBVV8JfIyV_T5NnYXxTcg0NF3xuPrSSmc",
            authDomain: "fricasse-arp8ru.firebaseapp.com",
            projectId: "fricasse-arp8ru",
            storageBucket: "fricasse-arp8ru.firebasestorage.app",
            messagingSenderId: "729591782379",
            appId: "1:729591782379:web:7da44e8fec57ef35e597ae"));
  } else {
    await Firebase.initializeApp();
  }
}
