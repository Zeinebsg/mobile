import '/components/button_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'snack_item_card_widget.dart' show SnackItemCardWidget;
import 'package:flutter/material.dart';

class SnackItemCardModel extends FlutterFlowModel<SnackItemCardWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for Button.
  late ButtonModel buttonModel;

  @override
  void initState(BuildContext context) {
    buttonModel = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    buttonModel.dispose();
  }
}
