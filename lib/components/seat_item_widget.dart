import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'seat_item_model.dart';
export 'seat_item_model.dart';

class SeatItemWidget extends StatefulWidget {
  const SeatItemWidget({
    super.key,
    String? status,
  }) : this.status = status ?? 'occupied';

  final String status;

  @override
  State<SeatItemWidget> createState() => _SeatItemWidgetState();
}

class _SeatItemWidgetState extends State<SeatItemWidget> {
  late SeatItemModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SeatItemModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24.0,
      height: 24.0,
      decoration: BoxDecoration(
        color: widget.status == 'selected'
            ? Color(0x00000000)
            : FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(6.0),
        shape: BoxShape.rectangle,
        border: Border.all(
          color: FlutterFlowTheme.of(context).alternate,
          width: 1.0,
        ),
      ),
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Icon(
        Icons.event_seat_rounded,
        color: widget.status == 'selected'
            ? Color(0x00000000)
            : FlutterFlowTheme.of(context).secondaryText30,
        size: 16.0,
      ),
    );
  }
}
