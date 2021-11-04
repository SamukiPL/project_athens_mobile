import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/presentation/data_loading/data_loading_state.dart';
import 'package:project_athens/dashboard_flow/domain/dashboard/dashboard_tiles_data_model.dart';
import 'package:project_athens/dashboard_flow/screens/dashboard/tiles/chart_tile/helpers/chart_color_manager.dart';
import 'package:project_athens/dashboard_flow/screens/dashboard/tiles/chart_tile/models/chart_tile_config_model.dart';
import 'package:project_athens/deputies_utils/domain/subscribed_deputy_model.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class DeputyChartTileConfigModel<T> extends ChartTileConfigModel<T> {
  DeputyChartTileConfigModel({
    required List<charts.Series<T, String>> seriesData,
    required DataLoadingState state,
    required Map<Color, SubscribedDeputyModel> legendImageToColorMap,
    required charts.BarGroupingType barGroupingType,
  }) : super(seriesData: seriesData, state: state, legendImageToColorMap: legendImageToColorMap, barGroupingType: barGroupingType);

  static final ChartColorManager _colorManager = ChartColorManager();

  /// unfortunately dart does not support factories with generic types
  static DeputyChartTileConfigModel<DashboardSimpleDeputyCounterYear> fromSimpleCounterPerYear(
      DashboardSimpleDeputiesCounterPerYearDataModel? data,
  ) {
    final List<charts.Series<DashboardSimpleDeputyCounterYear, String>> resultSeries = List.empty(growable: true);
    final Map<Color, SubscribedDeputyModel> legendImageToColorMap = Map<Color, SubscribedDeputyModel>();
    DataLoadingState _state = DataLoadingState.initialLoading();

    if (data == null) {
       _state = DataLoadingState.initialLoading();
    } else {
      for (final perDeputy in data.perDeputy) {
        final Color deputyColorShade = _colorManager.getColorForKey(
            perDeputy.subscribedDeputyModel.id);

        legendImageToColorMap.putIfAbsent(
            deputyColorShade, () => perDeputy.subscribedDeputyModel);

        final series = charts.Series<DashboardSimpleDeputyCounterYear, String>(
            id: perDeputy.subscribedDeputyModel.id,
            domainFn: (entry, _) => entry.year.toString(),
            measureFn: (entry, _) => entry.counter,
            data: perDeputy.perYear,
            seriesColor: charts.ColorUtil.fromDartColor(deputyColorShade),
            displayName: '',
            labelAccessorFn: (DashboardSimpleDeputyCounterYear model, _) =>
            '${model.year}: \$${model.counter.toString()}'
        );

        resultSeries.add(series);
      }

      _state = DataLoadingState.contentLoaded();
    }

    return DeputyChartTileConfigModel(
        seriesData: resultSeries,
        state: _state,
        legendImageToColorMap: legendImageToColorMap,
        barGroupingType: charts.BarGroupingType.grouped
    );
  }

  /// unfortunately dart does not support factories with generic types
  static DeputyChartTileConfigModel<DashboardSimpleDeputyCounter> fromSimpleCounter(
      DashboardSimpleDeputiesCounter? data,
  ) {
    final List<charts.Series<DashboardSimpleDeputyCounter, String>> resultSeries = List.empty(growable: true);
    final Map<Color, SubscribedDeputyModel> legendImageToColorMap = Map<Color, SubscribedDeputyModel>();
    DataLoadingState _state = DataLoadingState.initialLoading();

    if (data == null) {
      _state = DataLoadingState.initialLoading();
    } else {
      for (final perDeputy in data.perDeputy) {
        final Color deputyColorShade = _colorManager.getColorForKey(
            perDeputy.subscribedDeputyModel.id);

        legendImageToColorMap.putIfAbsent(
            deputyColorShade, () => perDeputy.subscribedDeputyModel);
      }

      final series = charts.Series<DashboardSimpleDeputyCounter, String>(
          id: 'Per deputy',
          domainFn: (entry, idx) =>  ((idx ?? 0) + 1).toString(),
          measureFn: (entry, idx) => entry.counter,
          data: data.perDeputy,
          colorFn: (entry, _) => charts.ColorUtil.fromDartColor(_colorManager.getColorForKey(
              entry.subscribedDeputyModel.id)),
          displayName: '',
          labelAccessorFn: (DashboardSimpleDeputyCounter model, _) =>
          '${model.subscribedDeputyModel.name}: \$${model.counter.toString()}'
      );

      resultSeries.add(series);

      _state = DataLoadingState.contentLoaded();
    }

    return DeputyChartTileConfigModel(
      seriesData: resultSeries,
      state: _state,
      legendImageToColorMap: legendImageToColorMap,
      barGroupingType: charts.BarGroupingType.stacked
    );
  }
}