import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'cast_avatar_model.dart';
export 'cast_avatar_model.dart';

class CastAvatarWidget extends StatefulWidget {
  const CastAvatarWidget({
    super.key,
    String? img,
    String? name,
    String? role,
  })  : this.img = img ??
            'https://dimg.dreamflow.cloud/v1/image/professional%20headshot%20of%20a%20woman%20with%20short%20hair',
        this.name = name ?? 'Elena Vance',
        this.role = role ?? 'Kira';

  final String img;
  final String name;
  final String role;

  @override
  State<CastAvatarWidget> createState() => _CastAvatarWidgetState();
}

class _CastAvatarWidgetState extends State<CastAvatarWidget> {
  late CastAvatarModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CastAvatarModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(30.0),
          child: CachedNetworkImage(
            fadeInDuration: Duration(milliseconds: 0),
            fadeOutDuration: Duration(milliseconds: 0),
            imageUrl: valueOrDefault<String>(
              widget.img,
              'https://dimg.dreamflow.cloud/v1/image/professional%20headshot%20of%20a%20woman%20with%20short%20hair',
            ),
            width: 60.0,
            height: 60.0,
            fit: BoxFit.cover,
            alignment: Alignment(0.0, 0.0),
          ),
        ),
        Text(
          valueOrDefault<String>(
            widget.name,
            'Elena Vance',
          ),
          maxLines: 1,
          style: FlutterFlowTheme.of(context).labelSmall.override(
                font: GoogleFonts.inter(
                  fontWeight:
                      FlutterFlowTheme.of(context).labelSmall.fontWeight,
                  fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                ),
                color: FlutterFlowTheme.of(context).primaryText,
                letterSpacing: 0.0,
                fontWeight: FlutterFlowTheme.of(context).labelSmall.fontWeight,
                fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                lineHeight: 1.27,
              ),
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          valueOrDefault<String>(
            widget.role,
            'Kira',
          ),
          style: FlutterFlowTheme.of(context).labelSmall.override(
                font: GoogleFonts.inter(
                  fontWeight:
                      FlutterFlowTheme.of(context).labelSmall.fontWeight,
                  fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                ),
                color: FlutterFlowTheme.of(context).secondaryText,
                fontSize: 10.0,
                letterSpacing: 0.0,
                fontWeight: FlutterFlowTheme.of(context).labelSmall.fontWeight,
                fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                lineHeight: 1.27,
              ),
        ),
      ].divide(SizedBox(height: 4.0)),
    );
  }
}
