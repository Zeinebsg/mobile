import '/components/button_widget.dart';
import '/components/snack_item_card_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'snack_bar_widget.dart' show SnackBarWidget;
import 'package:flutter/material.dart';

class SnackBarModel extends FlutterFlowModel<SnackBarWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for Button.
  late ButtonModel buttonModel1;
  // Model for SnackItemCard.
  late SnackItemCardModel snackItemCardModel1;
  // Model for SnackItemCard.
  late SnackItemCardModel snackItemCardModel2;
  // Model for SnackItemCard.
  late SnackItemCardModel snackItemCardModel3;
  // Model for SnackItemCard.
  late SnackItemCardModel snackItemCardModel4;
  // Model for SnackItemCard.
  late SnackItemCardModel snackItemCardModel5;
  // Model for SnackItemCard.
  late SnackItemCardModel snackItemCardModel6;
  // Model for SnackItemCard.
  late SnackItemCardModel snackItemCardModel7;
  // Model for SnackItemCard.
  late SnackItemCardModel snackItemCardModel8;
  // Model for Button.
  late ButtonModel buttonModel2;

  @override
  void initState(BuildContext context) {
    buttonModel1 = createModel(context, () => ButtonModel());
    snackItemCardModel1 = createModel(context, () => SnackItemCardModel());
    snackItemCardModel2 = createModel(context, () => SnackItemCardModel());
    snackItemCardModel3 = createModel(context, () => SnackItemCardModel());
    snackItemCardModel4 = createModel(context, () => SnackItemCardModel());
    snackItemCardModel5 = createModel(context, () => SnackItemCardModel());
    snackItemCardModel6 = createModel(context, () => SnackItemCardModel());
    snackItemCardModel7 = createModel(context, () => SnackItemCardModel());
    snackItemCardModel8 = createModel(context, () => SnackItemCardModel());
    buttonModel2 = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    buttonModel1.dispose();
    snackItemCardModel1.dispose();
    snackItemCardModel2.dispose();
    snackItemCardModel3.dispose();
    snackItemCardModel4.dispose();
    snackItemCardModel5.dispose();
    snackItemCardModel6.dispose();
    snackItemCardModel7.dispose();
    snackItemCardModel8.dispose();
    buttonModel2.dispose();
  }
}
