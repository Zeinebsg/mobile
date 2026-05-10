import 'package:flutter/material.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'addseance_widget.dart';

class AddseanceModel extends FlutterFlowModel<AddseanceWidget> {
  String? selectedFilmId;
  String? selectedFilmName;
  int? selectedFilmDuree;
  String? selectedSalleName;
  
  String? filmValue;
  String? salleValue;
  String? formatValue;
  String? qualiteValue;
  
  DateTime? datePicked;

  FormFieldController<String>? filmValueController;
  FormFieldController<String>? salleValueController;
  FormFieldController<String>? formatValueController;
  FormFieldController<String>? qualiteValueController;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}