import '/components/button_widget.dart';
import '/components/legend_item_widget.dart';
import '/components/seat_item_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'seat_selection_model.dart';
export 'seat_selection_model.dart';

class SeatSelectionWidget extends StatefulWidget {
  const SeatSelectionWidget({super.key});

  static String routeName = 'SeatSelection';
  static String routePath = '/seatSelection';

  @override
  State<SeatSelectionWidget> createState() => _SeatSelectionWidgetState();
}

class _SeatSelectionWidgetState extends State<SeatSelectionWidget> {
  late SeatSelectionModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SeatSelectionModel());
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
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 16.0, 24.0, 16.0),
                    child: Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FlutterFlowIconButton(
                            borderRadius: 8.0,
                            buttonSize: 40.0,
                            fillColor: Colors.transparent,
                            icon: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 20.0,
                            ),
                            onPressed: () {
                              print('IconButton pressed ...');
                            },
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'NEON GENESIS',
                                style: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .fontStyle,
                                      ),
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                      lineHeight: 1.35,
                                    ),
                              ),
                              Text(
                                'Tomorrow, 18:30 • Hall 4 (IMAX)',
                                style: FlutterFlowTheme.of(context)
                                    .labelSmall
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .labelSmall
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelSmall
                                            .fontStyle,
                                      ),
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .fontStyle,
                                      lineHeight: 1.27,
                                    ),
                              ),
                            ],
                          ),
                          FlutterFlowIconButton(
                            borderRadius: 8.0,
                            buttonSize: 40.0,
                            fillColor: Colors.transparent,
                            icon: Icon(
                              Icons.info_outlined,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 20.0,
                            ),
                            onPressed: () {
                              print('IconButton pressed ...');
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 1.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).alternate,
                      shape: BoxShape.rectangle,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: SingleChildScrollView(
                  primary: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 300.0,
                                    height: 4.0,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.transparent,
                                          FlutterFlowTheme.of(context).primary,
                                          Colors.transparent
                                        ],
                                        stops: [0.0, 0.5, 1.0],
                                        begin: AlignmentDirectional(-1.0, 0.0),
                                        end: AlignmentDirectional(1.0, 0),
                                      ),
                                      borderRadius: BorderRadius.circular(2.0),
                                      shape: BoxShape.rectangle,
                                    ),
                                  ),
                                  Text(
                                    'SCREEN',
                                    style: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .override(
                                          font: GoogleFonts.inter(
                                            fontWeight: FontWeight.bold,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmall
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelSmall
                                                  .fontStyle,
                                          lineHeight: 1.27,
                                        ),
                                  ),
                                ].divide(SizedBox(height: 8.0)),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      wrapWithModel(
                                        model: _model.seatItemModel1,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: SeatItemWidget(
                                          status: 'occupied',
                                        ),
                                      ),
                                      wrapWithModel(
                                        model: _model.seatItemModel2,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: SeatItemWidget(
                                          status: 'occupied',
                                        ),
                                      ),
                                      Container(
                                        width: 16.0,
                                      ),
                                      wrapWithModel(
                                        model: _model.seatItemModel3,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: SeatItemWidget(
                                          status: 'occupied',
                                        ),
                                      ),
                                      wrapWithModel(
                                        model: _model.seatItemModel4,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: SeatItemWidget(
                                          status: 'occupied',
                                        ),
                                      ),
                                      wrapWithModel(
                                        model: _model.seatItemModel5,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: SeatItemWidget(
                                          status: 'occupied',
                                        ),
                                      ),
                                      wrapWithModel(
                                        model: _model.seatItemModel6,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: SeatItemWidget(
                                          status: 'occupied',
                                        ),
                                      ),
                                      Container(
                                        width: 16.0,
                                      ),
                                      wrapWithModel(
                                        model: _model.seatItemModel7,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: SeatItemWidget(
                                          status: 'occupied',
                                        ),
                                      ),
                                      wrapWithModel(
                                        model: _model.seatItemModel8,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: SeatItemWidget(
                                          status: 'occupied',
                                        ),
                                      ),
                                    ].divide(SizedBox(width: 8.0)),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      wrapWithModel(
                                        model: _model.seatItemModel9,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: SeatItemWidget(
                                          status: 'occupied',
                                        ),
                                      ),
                                      wrapWithModel(
                                        model: _model.seatItemModel10,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: SeatItemWidget(
                                          status: 'occupied',
                                        ),
                                      ),
                                      Container(
                                        width: 16.0,
                                      ),
                                      wrapWithModel(
                                        model: _model.seatItemModel11,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: SeatItemWidget(
                                          status: 'occupied',
                                        ),
                                      ),
                                      wrapWithModel(
                                        model: _model.seatItemModel12,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: SeatItemWidget(
                                          status: 'selected',
                                        ),
                                      ),
                                      wrapWithModel(
                                        model: _model.seatItemModel13,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: SeatItemWidget(
                                          status: 'selected',
                                        ),
                                      ),
                                      wrapWithModel(
                                        model: _model.seatItemModel14,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: SeatItemWidget(
                                          status: 'occupied',
                                        ),
                                      ),
                                      Container(
                                        width: 16.0,
                                      ),
                                      wrapWithModel(
                                        model: _model.seatItemModel15,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: SeatItemWidget(
                                          status: 'occupied',
                                        ),
                                      ),
                                      wrapWithModel(
                                        model: _model.seatItemModel16,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: SeatItemWidget(
                                          status: 'occupied',
                                        ),
                                      ),
                                    ].divide(SizedBox(width: 8.0)),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      wrapWithModel(
                                        model: _model.seatItemModel17,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: SeatItemWidget(
                                          status: 'occupied',
                                        ),
                                      ),
                                      wrapWithModel(
                                        model: _model.seatItemModel18,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: SeatItemWidget(
                                          status: 'occupied',
                                        ),
                                      ),
                                      Container(
                                        width: 16.0,
                                      ),
                                      wrapWithModel(
                                        model: _model.seatItemModel19,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: SeatItemWidget(
                                          status: 'occupied',
                                        ),
                                      ),
                                      wrapWithModel(
                                        model: _model.seatItemModel20,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: SeatItemWidget(
                                          status: 'occupied',
                                        ),
                                      ),
                                      wrapWithModel(
                                        model: _model.seatItemModel21,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: SeatItemWidget(
                                          status: 'occupied',
                                        ),
                                      ),
                                      wrapWithModel(
                                        model: _model.seatItemModel22,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: SeatItemWidget(
                                          status: 'occupied',
                                        ),
                                      ),
                                      Container(
                                        width: 16.0,
                                      ),
                                      wrapWithModel(
                                        model: _model.seatItemModel23,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: SeatItemWidget(
                                          status: 'occupied',
                                        ),
                                      ),
                                      wrapWithModel(
                                        model: _model.seatItemModel24,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: SeatItemWidget(
                                          status: 'occupied',
                                        ),
                                      ),
                                    ].divide(SizedBox(width: 8.0)),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      wrapWithModel(
                                        model: _model.seatItemModel25,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: SeatItemWidget(
                                          status: 'occupied',
                                        ),
                                      ),
                                      wrapWithModel(
                                        model: _model.seatItemModel26,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: SeatItemWidget(
                                          status: 'occupied',
                                        ),
                                      ),
                                      Container(
                                        width: 16.0,
                                      ),
                                      wrapWithModel(
                                        model: _model.seatItemModel27,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: SeatItemWidget(
                                          status: 'occupied',
                                        ),
                                      ),
                                      wrapWithModel(
                                        model: _model.seatItemModel28,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: SeatItemWidget(
                                          status: 'occupied',
                                        ),
                                      ),
                                      wrapWithModel(
                                        model: _model.seatItemModel29,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: SeatItemWidget(
                                          status: 'occupied',
                                        ),
                                      ),
                                      wrapWithModel(
                                        model: _model.seatItemModel30,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: SeatItemWidget(
                                          status: 'occupied',
                                        ),
                                      ),
                                      Container(
                                        width: 16.0,
                                      ),
                                      wrapWithModel(
                                        model: _model.seatItemModel31,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: SeatItemWidget(
                                          status: 'occupied',
                                        ),
                                      ),
                                      wrapWithModel(
                                        model: _model.seatItemModel32,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: SeatItemWidget(
                                          status: 'occupied',
                                        ),
                                      ),
                                    ].divide(SizedBox(width: 8.0)),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      wrapWithModel(
                                        model: _model.seatItemModel33,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: SeatItemWidget(
                                          status: 'occupied',
                                        ),
                                      ),
                                      wrapWithModel(
                                        model: _model.seatItemModel34,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: SeatItemWidget(
                                          status: 'occupied',
                                        ),
                                      ),
                                      Container(
                                        width: 16.0,
                                      ),
                                      wrapWithModel(
                                        model: _model.seatItemModel35,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: SeatItemWidget(
                                          status: 'occupied',
                                        ),
                                      ),
                                      wrapWithModel(
                                        model: _model.seatItemModel36,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: SeatItemWidget(
                                          status: 'occupied',
                                        ),
                                      ),
                                      wrapWithModel(
                                        model: _model.seatItemModel37,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: SeatItemWidget(
                                          status: 'occupied',
                                        ),
                                      ),
                                      wrapWithModel(
                                        model: _model.seatItemModel38,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: SeatItemWidget(
                                          status: 'occupied',
                                        ),
                                      ),
                                      Container(
                                        width: 16.0,
                                      ),
                                      wrapWithModel(
                                        model: _model.seatItemModel39,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: SeatItemWidget(
                                          status: 'occupied',
                                        ),
                                      ),
                                      wrapWithModel(
                                        model: _model.seatItemModel40,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: SeatItemWidget(
                                          status: 'occupied',
                                        ),
                                      ),
                                    ].divide(SizedBox(width: 8.0)),
                                  ),
                                ].divide(SizedBox(height: 16.0)),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  wrapWithModel(
                                    model: _model.legendItemModel1,
                                    updateCallback: () => safeSetState(() {}),
                                    child: LegendItemWidget(
                                      color: Colors.transparent,
                                      label: 'Available',
                                    ),
                                  ),
                                  wrapWithModel(
                                    model: _model.legendItemModel2,
                                    updateCallback: () => safeSetState(() {}),
                                    child: LegendItemWidget(
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      label: 'Selected',
                                    ),
                                  ),
                                  wrapWithModel(
                                    model: _model.legendItemModel3,
                                    updateCallback: () => safeSetState(() {}),
                                    child: LegendItemWidget(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      label: 'Occupied',
                                    ),
                                  ),
                                ].divide(SizedBox(width: 24.0)),
                              ),
                            ].divide(SizedBox(height: 32.0)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.0),
                  topRight: Radius.circular(24.0),
                ),
                shape: BoxShape.rectangle,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 1.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).alternate,
                      shape: BoxShape.rectangle,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Selected Seats',
                                    style: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .override(
                                          font: GoogleFonts.inter(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmall
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmall
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .labelSmall
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelSmall
                                                  .fontStyle,
                                          lineHeight: 1.27,
                                        ),
                                  ),
                                  Text(
                                    'B4, B5',
                                    style: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .override(
                                          font: GoogleFonts.inter(
                                            fontWeight: FontWeight.bold,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleMedium
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleMedium
                                                  .fontStyle,
                                          lineHeight: 1.35,
                                        ),
                                  ),
                                ].divide(SizedBox(height: 4.0)),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'Total Price',
                                    style: FlutterFlowTheme.of(context)
                                        .labelSmall
                                        .override(
                                          font: GoogleFonts.inter(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmall
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmall
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .labelSmall
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelSmall
                                                  .fontStyle,
                                          lineHeight: 1.27,
                                        ),
                                  ),
                                  Text(
                                    '\$24.00',
                                    style: FlutterFlowTheme.of(context)
                                        .titleLarge
                                        .override(
                                          font: GoogleFonts.inter(
                                            fontWeight: FontWeight.bold,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleLarge
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleLarge
                                                  .fontStyle,
                                          lineHeight: 1.27,
                                        ),
                                  ),
                                ].divide(SizedBox(height: 4.0)),
                              ),
                            ],
                          ),
                          wrapWithModel(
                            model: _model.buttonModel,
                            updateCallback: () => safeSetState(() {}),
                            child: ButtonWidget(
                              content: 'Confirm Reservation',
                              icon: Icon(
                                Icons.local_activity_rounded,
                                color: FlutterFlowTheme.of(context).onPrimary,
                                size: 16.0,
                              ),
                              icon_present: true,
                              icon_end_present: false,
                              variant: 'primary',
                              size: 'large',
                              full_width: true,
                              loading: false,
                              disabled: false,
                            ),
                          ),
                        ].divide(SizedBox(height: 24.0)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
