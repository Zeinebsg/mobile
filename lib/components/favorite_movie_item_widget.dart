import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'favorite_movie_item_model.dart';
export 'favorite_movie_item_model.dart';

class FavoriteMovieItemWidget extends StatefulWidget {
  const FavoriteMovieItemWidget({
    super.key,
    String? img_desc,
  }) : this.img_desc = img_desc ??
            'https://dimg.dreamflow.cloud/v1/image/movie%20poster%20dark%20aesthetic%20cyberpunk';

  final String img_desc;

  @override
  State<FavoriteMovieItemWidget> createState() =>
      _FavoriteMovieItemWidgetState();
}

class _FavoriteMovieItemWidgetState extends State<FavoriteMovieItemWidget> {
  late FavoriteMovieItemModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FavoriteMovieItemModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 8.0, 0.0),
      child: Container(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4.0),
          child: Container(
            width: 100.0,
            height: 150.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              shape: BoxShape.rectangle,
            ),
            child: Stack(
              alignment: AlignmentDirectional(-1.0, -1.0),
              children: [
                CachedNetworkImage(
                  fadeInDuration: Duration(milliseconds: 0),
                  fadeOutDuration: Duration(milliseconds: 0),
                  imageUrl: valueOrDefault<String>(
                    widget.img_desc,
                    'https://dimg.dreamflow.cloud/v1/image/movie%20poster%20dark%20aesthetic%20cyberpunk',
                  ),
                  width: 100.0,
                  height: 150.0,
                  fit: BoxFit.cover,
                  alignment: Alignment(0.0, 0.0),
                ),
                Align(
                  alignment: AlignmentDirectional(0.0, 1.0),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          FlutterFlowTheme.of(context).background80,
                          Colors.transparent
                        ],
                        stops: [0.0, 0.4],
                        begin: AlignmentDirectional(0.0, 1.0),
                        end: AlignmentDirectional(0, -1.0),
                      ),
                      shape: BoxShape.rectangle,
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(1.0, -1.0),
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Container(
                        child: FlutterFlowIconButton(
                          borderRadius: 9999.0,
                          buttonSize: 40.0,
                          fillColor: FlutterFlowTheme.of(context).background53,
                          icon: Icon(
                            Icons.close_rounded,
                            color: FlutterFlowTheme.of(context).onPrimary,
                            size: 16.0,
                          ),
                          onPressed: () {
                            print('IconButton pressed ...');
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
