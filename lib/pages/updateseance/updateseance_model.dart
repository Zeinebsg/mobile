import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'updateseance_widget.dart';

class UpdateseanceModel extends FlutterFlowModel<UpdateseanceWidget> {
  String? selectedFilmName;
  
  // State fields
  String? filmValue;
  FormFieldController<String>? filmValueController;
  
  String? salleValue;
  FormFieldController<String>? salleValueController;
  
  String? formatValue;
  FormFieldController<String>? formatValueController;
  
  String? qualiteValue;
  FormFieldController<String>? qualiteValueController;
  
  DateTime? datePicked;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}