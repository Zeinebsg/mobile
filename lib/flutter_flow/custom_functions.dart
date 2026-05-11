import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/auth/firebase_auth/auth_util.dart';

String tmdbImage(String backdropPath) {
  return "https://image.tmdb.org/t/p/w1066_and_h600_bestv2/$backdropPath";
}

String numOfReviewsFormater(int numOfReviews) {
  var _formattedNumber = NumberFormat.compact().format(numOfReviews);
  return "($_formattedNumber)";
}

String durationInHM(int minutes) {
  Duration duration = Duration(minutes: minutes);
  return "${duration.inHours}h ${duration.inMinutes.remainder(60)}m";
}

String getYearFromDateTime(String date) {
  DateTime datetime = DateTime.parse(date);

  return datetime.year.toString();
}
