import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'tv_shows_details_model.dart';
export 'tv_shows_details_model.dart';

class TvShowsDetailsWidget extends StatefulWidget {
  const TvShowsDetailsWidget({
    super.key,
    this.tvId,
  });

  final int? tvId;

  static String routeName = 'TvShowsDetails';
  static String routePath = '/tvShowsDetails';

  @override
  State<TvShowsDetailsWidget> createState() => _TvShowsDetailsWidgetState();
}

class _TvShowsDetailsWidgetState extends State<TvShowsDetailsWidget> {
  late TvShowsDetailsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TvShowsDetailsModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      ),
    );
  }
}
