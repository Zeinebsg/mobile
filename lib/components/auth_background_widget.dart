import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_palette/material_palette.dart';
import 'package:provider/provider.dart';
import 'auth_background_model.dart';
export 'auth_background_model.dart';

class AuthBackgroundWidget extends StatefulWidget {
  const AuthBackgroundWidget({super.key});

  @override
  State<AuthBackgroundWidget> createState() => _AuthBackgroundWidgetState();
}

class _AuthBackgroundWidgetState extends State<AuthBackgroundWidget> {
  late AuthBackgroundModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AuthBackgroundModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: AlignmentDirectional(-1.0, -1.0),
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return SimplexGradientShaderFill(
                width: constraints.maxWidth.isFinite
                    ? constraints.maxWidth
                    : 200.0,
                height: constraints.maxHeight.isFinite
                    ? constraints.maxHeight
                    : 200.0,
                params: ShaderParams(values: {
                  'gradientAngle': 135.0,
                  'gradientScale': 0.89,
                  'gradientOffset': 0.0,
                  'noiseIntensity': 0.32,
                  'ditherStrength': 2.51,
                  'ditherScale': 0.29,
                  'animSpeed': 1.46,
                  'noiseScale': 6.36,
                  'sharpness': 2.2,
                  'colorCount': 6.76,
                  'softness': 0.0,
                  'exposure': 1.0,
                  'contrast': 1.0,
                  'bumpStrength': 0.0,
                  'lightDirX': 0.55,
                  'lightDirY': 0.45,
                  'lightDirZ': 1.0,
                  'lightIntensity': 1.15,
                  'ambient': 0.7,
                  'specular': 0.29,
                  'shininess': 40.76,
                  'metallic': 1.0,
                  'roughness': 1.0,
                  'edgeFade': 1.72,
                  'edgeFadeMode': 0.0
                }, colors: {
                  'color0': FlutterFlowTheme.of(context).primaryBackground,
                  'color1': FlutterFlowTheme.of(context).primary20,
                  'color2': FlutterFlowTheme.of(context).primaryBackground,
                  'color3': FlutterFlowTheme.of(context).primaryBackground,
                  'color4': FlutterFlowTheme.of(context).primaryBackground,
                  'color5': FlutterFlowTheme.of(context).primaryBackground,
                  'color6': FlutterFlowTheme.of(context).primaryBackground,
                  'color7': Color(0x00808080),
                  'color8': Color(0x00808080),
                  'color9': Color(0x00808080)
                }),
                animationMode: ShaderAnimationMode.continuous,
                cache: false,
              );
            },
          ),
          Container(
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).background60,
              shape: BoxShape.rectangle,
            ),
          ),
        ],
      ),
    );
  }
}
