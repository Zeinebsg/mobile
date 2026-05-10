import '/components/episode_card/episode_card_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'episodes_bottom_sheet_widget.dart' show EpisodesBottomSheetWidget;
import 'package:flutter/material.dart';

class EpisodesBottomSheetModel
    extends FlutterFlowModel<EpisodesBottomSheetWidget> {
  ///  State fields for stateful widgets in this component.

  // Models for EpisodeCard dynamic component.
  late FlutterFlowDynamicModels<EpisodeCardModel> episodeCardModels;

  @override
  void initState(BuildContext context) {
    episodeCardModels = FlutterFlowDynamicModels(() => EpisodeCardModel());
  }

  @override
  void dispose() {
    episodeCardModels.dispose();
  }
}
