import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class VoirfilmModel extends FlutterFlowModel {
  /// State fields for stateful widgets in this page.

  // State field(s) for searchField widget.
  FocusNode? searchFieldFocusNode;
  TextEditingController? searchFieldTextController;
  String? Function(BuildContext, String?)? searchFieldTextControllerValidator;
  
  // Stores action output result for API call
  ApiCallResponse? apiResult0jh;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    searchFieldFocusNode?.dispose();
    searchFieldTextController?.dispose();
  }
}