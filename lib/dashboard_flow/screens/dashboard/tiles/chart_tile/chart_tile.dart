import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/presentation/data_loading/data_loading_state.dart';
import 'package:project_athens/athens_core/presentation/grid/tiles/simple_tile/simple_tile.dart';
import 'package:project_athens/dashboard_flow/screens/dashboard/tiles/chart_tile/helpers/chart_image_symbol_renderer.dart';
import 'package:project_athens/dashboard_flow/screens/dashboard/tiles/chart_tile/models/deputy_chart_tile_config_model.dart';
import 'package:project_athens/deputies_utils/domain/subscribed_deputy_model.dart';
import 'package:provider/provider.dart';

class ChartTile extends SimpleTile {
  final Stream<DeputyChartTileConfigModel> chartConfiguration;
  final String title;

  ChartTile({required this.chartConfiguration, required this.title}) : super(text: "", key: Key('tile_chart'));

  @override
  Widget build(BuildContext context) {
    return super.buildTile(
        context: context,
        tile: _getChartTile()
    );
  }

  Widget _getChartTile() {
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
                child: Icon(
                  Icons.settings,
                  size: 20,
                  color: Colors.black.withOpacity(0.6),
                )
              )
            ],
          ),
          Expanded(
            child: StreamProvider.value(
            initialData: null,
            value: chartConfiguration,
            child: Consumer<DeputyChartTileConfigModel?>(
              builder: (context, data, _) =>
                  data != null && data.state is ContentLoaded
                    ? charts.BarChart(
                      data.seriesData,
                      animate: true,
                      barGroupingType: data.barGroupingType,
                      // behaviors: [
                      //   charts.SeriesLegend(
                      //     // Positions for "start" and "end" will be left and right respectively
                      //     // for widgets with a build context that has directionality ltr.
                      //     // For rtl, "start" and "end" will be right and left respectively.
                      //     // Since this example has directionality of ltr, the legend is
                      //     // positioned on the right side of the chart.
                      //     position: charts.BehaviorPosition.end,
                      //     // By default, if the position of the chart is on the left or right of
                      //     // the chart, [horizontalFirst] is set to false. This means that the
                      //     // legend entries will grow as new rows first instead of a new column.
                      //     horizontalFirst: false,
                      //     // This defines the padding around each legend entry.
                      //     cellPadding: new EdgeInsets.only(right: 4.0, bottom: 4.0),
                      //     // Set show measures to true to display measures in series legend,
                      //     // when the datum is selected.
                      //     showMeasures: true,
                      //
                      //     // Optionally provide a measure formatter to format the measure value.
                      //     // If none is specified the value is formatted as a decimal.
                      //     measureFormatter: (num? value) {
                      //       return value == null ? '-' : '${value}';
                      //     },
                      //   )
                      // ],
                      defaultRenderer: charts.BarRendererConfig(
                        symbolRenderer: ChartImageSymbolRenderer(data.legendImageToColorMap),
                      ),
                    )
                    : Container(),
            ),
          )),
          Container(
            child: StreamProvider.value(
              initialData: null,
              value: chartConfiguration,
              child: Consumer<DeputyChartTileConfigModel?>(
                builder: (context, data, _) =>
                data != null && data.state is ContentLoaded
                    ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: _getLegend(data),
                    ) : Container(),
              ),
            )

          )
        ],
      )
    );
  }

  List<Widget> _getLegend(DeputyChartTileConfigModel config) {
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
}