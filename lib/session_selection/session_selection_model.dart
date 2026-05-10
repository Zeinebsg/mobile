import '/components/button_widget.dart';
import '/components/date_chip_widget.dart';
import '/components/screen_type_card_widget.dart';
import '/components/time_chip_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'session_selection_widget.dart' show SessionSelectionWidget;
import 'package:flutter/material.dart';

class SessionSelectionModel extends FlutterFlowModel<SessionSelectionWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for DateChip.
  late DateChipModel dateChipModel1;
  // Model for DateChip.
  late DateChipModel dateChipModel2;
  // Model for DateChip.
  late DateChipModel dateChipModel3;
  // Model for DateChip.
  late DateChipModel dateChipModel4;
  // Model for DateChip.
  late DateChipModel dateChipModel5;
  // Model for DateChip.
  late DateChipModel dateChipModel6;
  // Model for ScreenTypeCard.
  late ScreenTypeCardModel screenTypeCardModel1;
  // Model for ScreenTypeCard.
  late ScreenTypeCardModel screenTypeCardModel2;
  // Model for ScreenTypeCard.
  late ScreenTypeCardModel screenTypeCardModel3;
  // Model for TimeChip.
  late TimeChipModel timeChipModel1;
  // Model for TimeChip.
  late TimeChipModel timeChipModel2;
  // Model for TimeChip.
  late TimeChipModel timeChipModel3;
  // Model for TimeChip.
  late TimeChipModel timeChipModel4;
  // Model for TimeChip.
  late TimeChipModel timeChipModel5;
  // Model for TimeChip.
  late TimeChipModel timeChipModel6;
  // Model for Button.
  late ButtonModel buttonModel;

  @override
  void initState(BuildContext context) {
    dateChipModel1 = createModel(context, () => DateChipModel());
    dateChipModel2 = createModel(context, () => DateChipModel());
    dateChipModel3 = createModel(context, () => DateChipModel());
    dateChipModel4 = createModel(context, () => DateChipModel());
    dateChipModel5 = createModel(context, () => DateChipModel());
    dateChipModel6 = createModel(context, () => DateChipModel());
    screenTypeCardModel1 = createModel(context, () => ScreenTypeCardModel());
    screenTypeCardModel2 = createModel(context, () => ScreenTypeCardModel());
    screenTypeCardModel3 = createModel(context, () => ScreenTypeCardModel());
    timeChipModel1 = createModel(context, () => TimeChipModel());
    timeChipModel2 = createModel(context, () => TimeChipModel());
    timeChipModel3 = createModel(context, () => TimeChipModel());
    timeChipModel4 = createModel(context, () => TimeChipModel());
    timeChipModel5 = createModel(context, () => TimeChipModel());
    timeChipModel6 = createModel(context, () => TimeChipModel());
    buttonModel = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    dateChipModel1.dispose();
    dateChipModel2.dispose();
    dateChipModel3.dispose();
    dateChipModel4.dispose();
    dateChipModel5.dispose();
    dateChipModel6.dispose();
    screenTypeCardModel1.dispose();
    screenTypeCardModel2.dispose();
    screenTypeCardModel3.dispose();
    timeChipModel1.dispose();
    timeChipModel2.dispose();
    timeChipModel3.dispose();
    timeChipModel4.dispose();
    timeChipModel5.dispose();
    timeChipModel6.dispose();
    buttonModel.dispose();
  }
}
