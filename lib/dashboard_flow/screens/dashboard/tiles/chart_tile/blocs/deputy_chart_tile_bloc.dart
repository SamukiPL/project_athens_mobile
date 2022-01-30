import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/dashboard_flow/domain/dashboard/dashboard_tiles_data_model.dart';
import 'package:project_athens/dashboard_flow/screens/dashboard/tiles/chart_tile/helpers/chart_color_manager.dart';
import 'package:project_athens/dashboard_flow/screens/dashboard/tiles/chart_tile/blocs/chart_tile_bloc.dart';
import 'package:project_athens/deputies_utils/domain/subscribed_deputy_model.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';

class DeputyChartTileBloc<SERIES_DATA, FROM_DATA_STREAM> extends ChartTileBloc<SERIES_DATA, FROM_DATA_STREAM> {
  DeputyChartTileBloc({
    required List<charts.Series<SERIES_DATA, String>> Function(FROM_DATA_STREAM? model, ChartTileBloc<SERIES_DATA, FROM_DATA_STREAM> bloc) mapToSeriesFn,
    required Stream<FROM_DATA_STREAM?> dataStream,
    required Map<Color, SubscribedDeputyModel> legendImageToColorMap,
    required charts.BarGroupingType barGroupingType,
  }) : super(
      mapToSeriesFn: mapToSeriesFn,
      dataStream: dataStream,
      legendImageToColorMap: legendImageToColorMap,
      barGroupingType: barGroupingType,
  );

  /// share across all charts that are actaully about a deputy, so that once
  /// we assign a color to deputy, it's stays till end
  static final ChartColorManager _colorManager = ChartColorManager();

  /// unfortunately dart does not support factories with generic types
  static DeputyChartTileBloc<DashboardSimpleDeputyCounterYear, DashboardSimpleDeputiesCounterPerYearDataModel> fromSimpleCounterPerYearStream(
      Stream<DashboardSimpleDeputiesCounterPerYearDataModel?> dataStream,
  ) {
    final Map<Color, SubscribedDeputyModel> legendImageToColorMap = Map<Color, SubscribedDeputyModel>();

    final mapToSeriesFn = (DashboardSimpleDeputiesCounterPerYearDataModel? model, ChartTileBloc<DashboardSimpleDeputyCounterYear, DashboardSimpleDeputiesCounterPerYearDataModel> bloc) {
      final List<charts.Series<DashboardSimpleDeputyCounterYear, String>> resultSeries = List.empty(growable: true);

      if (model == null) {
        bloc.showLoader();

        return resultSeries;
      } else {
        for (final perDeputy in model.perDeputy) {
          final Color deputyColorShade = _colorManager.getColorForKey(
              perDeputy.subscribedDeputyModel.id);

          legendImageToColorMap.putIfAbsent(
              deputyColorShade, () => perDeputy.subscribedDeputyModel);

          final series = charts.Series<DashboardSimpleDeputyCounterYear,
              String>(
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

        bloc.hideLoader();

        return resultSeries;
      }
    };

    return DeputyChartTileBloc(
        mapToSeriesFn: mapToSeriesFn,
        dataStream: dataStream,
        legendImageToColorMap: legendImageToColorMap,
        barGroupingType: charts.BarGroupingType.grouped,
    );
  }

  /// unfortunately dart does not support factories with generic types
  static DeputyChartTileBloc<DashboardSimpleDeputyCounter, DashboardSimpleDeputiesCounter> fromSimpleCounterStream(
      Stream<DashboardSimpleDeputiesCounter?> dataStream,
  ) {
    final Map<Color, SubscribedDeputyModel> legendImageToColorMap = Map<Color, SubscribedDeputyModel>();

    final mapToSeriesFn = (DashboardSimpleDeputiesCounter? model, ChartTileBloc<DashboardSimpleDeputyCounter, DashboardSimpleDeputiesCounter> bloc) {
      final List<charts.Series<DashboardSimpleDeputyCounter, String>> resultSeries = List.empty(growable: true);

      if (model == null) {
        bloc.showLoader();
        return resultSeries;
      } else {
        for (final perDeputy in model.perDeputy) {
          final Color deputyColorShade = _colorManager.getColorForKey(
          perDeputy.subscribedDeputyModel.id);

          legendImageToColorMap.putIfAbsent(
          deputyColorShade, () => perDeputy.subscribedDeputyModel);
        }

        final series = charts.Series<DashboardSimpleDeputyCounter, String>(
          id: 'Per deputy',
          domainFn: (entry, idx) =>  ((idx ?? 0) + 1).toString(),
          measureFn: (entry, idx) => entry.counter,
          data: model.perDeputy,
          colorFn: (entry, _) => charts.ColorUtil.fromDartColor(_colorManager.getColorForKey(
          entry.subscribedDeputyModel.id)),
          displayName: '',
          labelAccessorFn: (DashboardSimpleDeputyCounter model, _) =>
          '${model.subscribedDeputyModel.name}: \$${model.counter.toString()}'
        );

        resultSeries.add(series);

        bloc.hideLoader();
        return resultSeries;
      }
    };

    return DeputyChartTileBloc(
      mapToSeriesFn: mapToSeriesFn,
      dataStream: dataStream,
      legendImageToColorMap: legendImageToColorMap,
      barGroupingType: charts.BarGroupingType.stacked
    );
  }
}