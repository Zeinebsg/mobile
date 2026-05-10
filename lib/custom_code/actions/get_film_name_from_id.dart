// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:cloud_firestore/cloud_firestore.dart';

Future<String> getFilmNameFromId(String filmId) async {
  /// MODIFY CODE ONLY BELOW THIS LINE

  if (filmId == null || filmId.isEmpty) {
    return '';
  }

  try {
    // Chercher le film dans la collection "films" par son ID
    DocumentSnapshot filmDoc =
        await FirebaseFirestore.instance.collection('films').doc(filmId).get();

    if (filmDoc.exists) {
      Map<String, dynamic> data = filmDoc.data() as Map<String, dynamic>;
      return data['titre'] ?? data['filmName'] ?? '';
    }

    return '';
  } catch (e) {
    return '';
  }

  /// MODIFY CODE ONLY ABOVE THIS LINE
}
