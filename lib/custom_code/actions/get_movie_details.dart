// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:convert';
import 'package:http/http.dart' as http;

Future<dynamic> getMovieDetails(String movieId) async {
  final apiKey = '81678c3f61130b7140ec8c6c51cab856'; // ← NOUVELLE CLÉ
  final url =
      'https://api.themoviedb.org/3/movie/$movieId?api_key=$apiKey&language=fr-FR&append_to_response=credits';

  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return {};
    }
  } catch (e) {
    return {};
  }
}
