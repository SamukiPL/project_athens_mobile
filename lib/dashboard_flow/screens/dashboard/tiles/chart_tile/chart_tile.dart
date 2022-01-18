import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/presentation/data_loading/data_loading_state.dart';
import 'package:project_athens/athens_core/presentation/grid/tiles/simple_tile/simple_tile.dart';
import 'package:project_athens/dashboard_flow/screens/dashboard/tiles/chart_tile/chart_tombstone.dart';
import 'package:project_athens/dashboard_flow/screens/dashboard/tiles/chart_tile/helpers/chart_image_symbol_renderer.dart';
import 'package:project_athens/dashboard_flow/screens/dashboard/tiles/chart_tile/blocs/deputy_chart_tile_bloc.dart';
import 'package:project_athens/dashboard_flow/screens/dashboard/tiles/chart_tile/models/chart_series_thombstone_model.dart';
import 'package:project_athens/deputies_utils/domain/subscribed_deputy_model.dart';
import 'package:provider/provider.dart';

class ChartTile<SERIES_DATA, FROM_DATA_STREAM> extends SimpleTile {
  @override
  final DeputyChartTileBloc<SERIES_DATA, FROM_DATA_STREAM> bloc;
  final String title;

  ChartTile({required this.bloc, required this.title, required Key key}) : super(text: "", key: key, bloc: bloc);

  @override
  Widget build(BuildContext context) {
    return super.buildTile(
        context: context,
        tile: _getChartTile(context)
    );
  }

  Widget _getChartTile(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 12
                  ),
                ),
              ),
              Container(
                child: GestureDetector(
                  onTap: () => bloc.openExperimentalInfoDialog(context),
                  child: Icon(
                    Icons.science,
                    size: 20,
                    color: Colors.black.withOpacity(0.6),
                  )
                )
              )
            ],
          ),
          Expanded(
            child: StreamProvider<List<charts.Series<dynamic, String>>>.value(
            initialData: List.empty(),
            value: bloc.seriesDataStream,
            child: Consumer<List<charts.Series<dynamic, String>>>(
              builder: (context, data, _) =>
                  bloc.currentLoadingState is ContentLoaded
                    ? charts.BarChart(
                      data,
                      animate: true,
                      barGroupingType: bloc.barGroupingType,
                      defaultRenderer: charts.BarRendererConfig(
                        symbolRenderer: ChartImageSymbolRenderer(bloc.legendImageToColorMap),
                      ),
                    )
                    : ChartTombstone(),
            ),
          )),
          Container(
            child: StreamProvider<List<charts.Series<dynamic, String>>>.value(
              initialData: List.empty(),
              value: bloc.seriesDataStream,
              child: Consumer<List<charts.Series<dynamic, String>>>(
                builder: (context, data, _) =>
                bloc.currentLoadingState is ContentLoaded
                    ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: _getLegend(bloc),
                    ) : Container(),
              ),
            )

          )
        ],
      )
    );
  }

  List<Widget> _getLegend(DeputyChartTileBloc config) {
    final List<Widget> widgets = List.empty(growable: true);

    config.legendImageToColorMap.forEach((key, value) {
      final widget = _buildAvatar(key, value);

      widgets.add(widget);
    });

    return widgets;
  }

  Widget _buildAvatar(Color color, SubscribedDeputyModel deputy) {
    return Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 2)
        ),
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: deputy.thumbnailUrl,
            filterQuality: FilterQuality.high,
            fit: BoxFit.cover,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) =>
                Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2)
                  ),
                  child: Center(
                      child: Text(
                        deputy.name,
                        style: TextStyle(
                            fontSize: 12
                        ),
                      )
                  ),
                ),
            width: 25,
            height: 25,
            memCacheHeight: 700,
            memCacheWidth: 700,
            alignment: Alignment.center,
          ),
        )
    );
  }

  Widget _getTombstoneChart() {
    return StreamProvider<List<charts.Series<ChartSeriesTombstoneModel, String>>>.value(
        initialData: List.empty(),
        value: bloc.tombstoneLoadingSeries,
        child: Consumer<List<charts.Series<ChartSeriesTombstoneModel, String>>>(
          builder: (context, data, _) =>
          Expanded(
            child:
            charts.BarChart(
              data,
              animate: true,
              barGroupingType: bloc.barGroupingType,
              defaultRenderer: charts.BarRendererConfig(
                symbolRenderer: ChartImageSymbolRenderer(bloc.legendImageToColorMap),
              ),
            )
          )
      )
    );
  }
}