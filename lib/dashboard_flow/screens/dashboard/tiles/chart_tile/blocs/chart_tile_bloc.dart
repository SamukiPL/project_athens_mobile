import 'dart:math';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/presentation/grid/tiles/simple_tile/simple_tile_bloc.dart';
import 'package:project_athens/dashboard_flow/screens/dashboard/tiles/chart_tile/models/chart_series_thombstone_model.dart';
import 'package:project_athens/deputies_utils/domain/subscribed_deputy_model.dart';
import 'package:rxdart/rxdart.dart';

class ChartTileBloc<SERIES_DATA, FROM_DATA_STREAM> extends SimpleTileBloc {
  final List<charts.Series<SERIES_DATA, String>> Function(FROM_DATA_STREAM? model, ChartTileBloc<SERIES_DATA, FROM_DATA_STREAM> bloc) mapToSeriesFn;
  final Stream<FROM_DATA_STREAM?> dataStream;
  final charts.BarGroupingType barGroupingType;
  Stream<List<charts.Series<dynamic, String>>> get seriesDataStream =>
      dataStream.map((model) => mapToSeriesFn(model, this));

  /// A hack which will allow us to manipulate legend image based on given color
  final Map<Color, SubscribedDeputyModel> legendImageToColorMap;

  Stream<List<charts.Series<ChartSeriesTombstoneModel, String>>> get tombstoneLoadingSeries => Rx.timer(null, Duration(milliseconds: 200)).map((event) {
    final random = new Random();

    final List<charts.Series<ChartSeriesTombstoneModel, String>> tombstoneSeries = [
      charts.Series<ChartSeriesTombstoneModel, String>(
        data: List.generate(5, (int index) => ChartSeriesTombstoneModel('', random.nextInt(index + 1) * random.nextInt(5))),
        measureFn: (model, _) => model.measure,
        domainFn: (model, _) => ((_!) + 1).toString(),
        id: 'tombstone',
        colorFn: (model, int? index) => charts.ColorUtil.fromDartColor(Colors.black.withOpacity((index! * 5 + 10) / 100))
      )
    ];

    return tombstoneSeries;
  });

  ChartTileBloc({
    required this.mapToSeriesFn,
    required this.dataStream,
    required this.legendImageToColorMap,
    required this.barGroupingType,
  });
}