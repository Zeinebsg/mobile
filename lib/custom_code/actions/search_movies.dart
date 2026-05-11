// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/actions/index.dart';
import '/flutter_flow/custom_functions.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<dynamic>> searchMovies(String query) async {
  final apiKey = '81678c3f61130b7140ec8c6c51cab856';
  final url =
      'https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=${Uri.encodeComponent(query)}&language=fr-FR';

  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['results'] as List<dynamic>? ?? [];
      return results;
    } else {
      print('Erreur API: ${response.statusCode}');
      return [];
    }
  } catch (e) {
    print('Exception: $e');
    return [];
  }
}
