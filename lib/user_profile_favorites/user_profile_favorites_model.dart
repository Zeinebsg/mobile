import '/components/button_widget.dart';
import '/components/favorite_movie_item_widget.dart';
import '/components/profile_action_item_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'user_profile_favorites_widget.dart' show UserProfileFavoritesWidget;
import 'package:flutter/material.dart';

class UserProfileFavoritesModel
    extends FlutterFlowModel<UserProfileFavoritesWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for Button.
  late ButtonModel buttonModel1;
  // Model for FavoriteMovieItem.
  late FavoriteMovieItemModel favoriteMovieItemModel1;
  // Model for FavoriteMovieItem.
  late FavoriteMovieItemModel favoriteMovieItemModel2;
  // Model for FavoriteMovieItem.
  late FavoriteMovieItemModel favoriteMovieItemModel3;
  // Model for FavoriteMovieItem.
  late FavoriteMovieItemModel favoriteMovieItemModel4;
  // Model for FavoriteMovieItem.
  late FavoriteMovieItemModel favoriteMovieItemModel5;
  // Model for ProfileActionItem.
  late ProfileActionItemModel profileActionItemModel1;
  // Model for ProfileActionItem.
  late ProfileActionItemModel profileActionItemModel2;
  // Model for ProfileActionItem.
  late ProfileActionItemModel profileActionItemModel3;
  // Model for ProfileActionItem.
  late ProfileActionItemModel profileActionItemModel4;
  // Model for ProfileActionItem.
  late ProfileActionItemModel profileActionItemModel5;
  // Model for Button.
  late ButtonModel buttonModel2;

  @override
  void initState(BuildContext context) {
    buttonModel1 = createModel(context, () => ButtonModel());
    favoriteMovieItemModel1 =
        createModel(context, () => FavoriteMovieItemModel());
    favoriteMovieItemModel2 =
        createModel(context, () => FavoriteMovieItemModel());
    favoriteMovieItemModel3 =
        createModel(context, () => FavoriteMovieItemModel());
    favoriteMovieItemModel4 =
        createModel(context, () => FavoriteMovieItemModel());
    favoriteMovieItemModel5 =
        createModel(context, () => FavoriteMovieItemModel());
    profileActionItemModel1 =
        createModel(context, () => ProfileActionItemModel());
    profileActionItemModel2 =
        createModel(context, () => ProfileActionItemModel());
    profileActionItemModel3 =
        createModel(context, () => ProfileActionItemModel());
    profileActionItemModel4 =
        createModel(context, () => ProfileActionItemModel());
    profileActionItemModel5 =
        createModel(context, () => ProfileActionItemModel());
    buttonModel2 = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    buttonModel1.dispose();
    favoriteMovieItemModel1.dispose();
    favoriteMovieItemModel2.dispose();
    favoriteMovieItemModel3.dispose();
    favoriteMovieItemModel4.dispose();
    favoriteMovieItemModel5.dispose();
    profileActionItemModel1.dispose();
    profileActionItemModel2.dispose();
    profileActionItemModel3.dispose();
    profileActionItemModel4.dispose();
    profileActionItemModel5.dispose();
    buttonModel2.dispose();
  }
}
