import 'dart:convert';

import '/components/summary_row_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'success_payment_widget.dart' show SuccessPaymentWidget;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SuccessPaymentModel extends FlutterFlowModel<SuccessPaymentWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for SummaryRow.
  late SummaryRowModel summaryRowModel1;
  // Model for SummaryRow.
  late SummaryRowModel summaryRowModel2;
  // Model for SummaryRow.
  late SummaryRowModel summaryRowModel3;

  // Quote data
  Map<String, dynamic>? quoteData;
  late Future<Map<String, dynamic>?> quotesFuture;

  @override
  void initState(BuildContext context) {
    summaryRowModel1 = createModel(context, () => SummaryRowModel());
    summaryRowModel2 = createModel(context, () => SummaryRowModel());
    summaryRowModel3 = createModel(context, () => SummaryRowModel());
    quotesFuture = fetchDailyQuote();
  }

  Future<Map<String, dynamic>?> fetchDailyQuote() async {
    const String apiKey = 'anIAV9MBU8YYKdqr4KtBCj3guQT7LVrkcodjRUjC';
    const String url = 'https://api.api-ninjas.com/v1/quotes';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'X-Api-Key': apiKey,
        },
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        if (data.isNotEmpty) {
          return data[0] as Map<String, dynamic>;
        }
      }
    } catch (e) {
      print('Error fetching quote: $e');
    }
    return null;
  }

  @override
  void dispose() {
    summaryRowModel1.dispose();
    summaryRowModel2.dispose();
    summaryRowModel3.dispose();
  }
}
