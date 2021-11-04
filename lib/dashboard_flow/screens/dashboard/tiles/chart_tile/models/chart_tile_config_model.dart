import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/presentation/data_loading/data_loading_state.dart';
import 'package:project_athens/deputies_utils/domain/subscribed_deputy_model.dart';

class ChartTileConfigModel<T> {
  final List<charts.Series<T, String>> seriesData;
  final charts.BarGroupingType barGroupingType;
  DataLoadingState state;

  /// A hack which will allow us to manipulate legend image based on given color
  final Map<Color, SubscribedDeputyModel> legendImageToColorMap;

  ChartTileConfigModel({
    required this.seriesData,
    required this.state,
    required this.legendImageToColorMap,
    required this.barGroupingType
  });
}