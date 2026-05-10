import '/components/category_chip_widget.dart';
import '/components/search_result_item_widget.dart';
import '/components/text_field_widget.dart';
import '/components/trending_card_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'search_discovery_widget.dart' show SearchDiscoveryWidget;
import 'package:flutter/material.dart';

class SearchDiscoveryModel extends FlutterFlowModel<SearchDiscoveryWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for TextField.
  late TextFieldModel textFieldModel;
  // Model for CategoryChip.
  late CategoryChipModel categoryChipModel1;
  // Model for CategoryChip.
  late CategoryChipModel categoryChipModel2;
  // Model for CategoryChip.
  late CategoryChipModel categoryChipModel3;
  // Model for CategoryChip.
  late CategoryChipModel categoryChipModel4;
  // Model for CategoryChip.
  late CategoryChipModel categoryChipModel5;
  // Model for CategoryChip.
  late CategoryChipModel categoryChipModel6;
  // Model for SearchResultItem.
  late SearchResultItemModel searchResultItemModel1;
  // Model for SearchResultItem.
  late SearchResultItemModel searchResultItemModel2;
  // Model for SearchResultItem.
  late SearchResultItemModel searchResultItemModel3;
  // Model for SearchResultItem.
  late SearchResultItemModel searchResultItemModel4;
  // Model for SearchResultItem.
  late SearchResultItemModel searchResultItemModel5;
  // Model for TrendingCard.
  late TrendingCardModel trendingCardModel1;
  // Model for TrendingCard.
  late TrendingCardModel trendingCardModel2;
  // Model for TrendingCard.
  late TrendingCardModel trendingCardModel3;
  // Model for TrendingCard.
  late TrendingCardModel trendingCardModel4;
  // Model for TrendingCard.
  late TrendingCardModel trendingCardModel5;

  @override
  void initState(BuildContext context) {
    textFieldModel = createModel(context, () => TextFieldModel());
    categoryChipModel1 = createModel(context, () => CategoryChipModel());
    categoryChipModel2 = createModel(context, () => CategoryChipModel());
    categoryChipModel3 = createModel(context, () => CategoryChipModel());
    categoryChipModel4 = createModel(context, () => CategoryChipModel());
    categoryChipModel5 = createModel(context, () => CategoryChipModel());
    categoryChipModel6 = createModel(context, () => CategoryChipModel());
    searchResultItemModel1 =
        createModel(context, () => SearchResultItemModel());
    searchResultItemModel2 =
        createModel(context, () => SearchResultItemModel());
    searchResultItemModel3 =
        createModel(context, () => SearchResultItemModel());
    searchResultItemModel4 =
        createModel(context, () => SearchResultItemModel());
    searchResultItemModel5 =
        createModel(context, () => SearchResultItemModel());
    trendingCardModel1 = createModel(context, () => TrendingCardModel());
    trendingCardModel2 = createModel(context, () => TrendingCardModel());
    trendingCardModel3 = createModel(context, () => TrendingCardModel());
    trendingCardModel4 = createModel(context, () => TrendingCardModel());
    trendingCardModel5 = createModel(context, () => TrendingCardModel());
  }

  @override
  void dispose() {
    textFieldModel.dispose();
    categoryChipModel1.dispose();
    categoryChipModel2.dispose();
    categoryChipModel3.dispose();
    categoryChipModel4.dispose();
    categoryChipModel5.dispose();
    categoryChipModel6.dispose();
    searchResultItemModel1.dispose();
    searchResultItemModel2.dispose();
    searchResultItemModel3.dispose();
    searchResultItemModel4.dispose();
    searchResultItemModel5.dispose();
    trendingCardModel1.dispose();
    trendingCardModel2.dispose();
    trendingCardModel3.dispose();
    trendingCardModel4.dispose();
    trendingCardModel5.dispose();
  }
}
