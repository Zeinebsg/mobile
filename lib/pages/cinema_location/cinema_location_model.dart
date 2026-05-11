import '/flutter_flow/flutter_flow_util.dart';
import 'cinema_location_widget.dart' show CinemaLocationWidget;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CinemaLocationModel extends FlutterFlowModel<CinemaLocationWidget> {
  ///  State fields for stateful widgets in this page.

  static const String _apiNinjasKey = 'anIAV9MBU8YYKdqr4KtBCj3guQT7LVrkcodjRUjC';

  Future<Map<String, dynamic>?> fetchWeather() async {
    try {
      final response = await http.get(
        Uri.parse('https://api.api-ninjas.com/v1/weather?lat=36.8065&lon=10.1815'),
        headers: {'X-Api-Key': _apiNinjasKey},
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () => http.Response('timeout', 408),
      );

      if (response.statusCode == 200) {
        final dynamic data = jsonDecode(response.body);
        if (data is Map<String, dynamic>) {
          return data;
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
