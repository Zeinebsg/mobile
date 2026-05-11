import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'filmdetails_model.dart';
export 'filmdetails_model.dart';

class FilmdetailsWidget extends StatefulWidget {
  const FilmdetailsWidget({super.key});

  static String routeName = 'filmdetails';
  static String routePath = '/filmdetails';

  @override
  State<FilmdetailsWidget> createState() => _FilmdetailsWidgetState();
}

class _FilmdetailsWidgetState extends State<FilmdetailsWidget> {
  late FilmdetailsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FilmdetailsModel());
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
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [],
          ),
        ),
      ),
    );
  }
}
