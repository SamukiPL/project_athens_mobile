import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/dashboard_flow/screens/dashboard/tiles/chart_tile/models/chart_series_thombstone_model.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ChartTombstone extends StatefulWidget {
  @override
  ChartTombstoneState createState() => ChartTombstoneState();
}

class ChartTombstoneState extends State<ChartTombstone> {
  final random = Random();
  List<charts.Series<ChartSeriesTombstoneModel, String>> tombstoneSeries = List.empty();
  Timer? timer;

  void changeData() {
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    timer = Timer(new Duration(milliseconds: 700), () {
      setState(() {
        tombstoneSeries = _generateRandomData();
      });
    });

    tombstoneSeries = _generateRandomData();

    return charts.BarChart(
      tombstoneSeries,
      animate: true,
      animationDuration: new Duration(milliseconds: 500),
      primaryMeasureAxis: charts.NumericAxisSpec(
          showAxisLine: false,
          tickProviderSpec: charts.BasicNumericTickProviderSpec(desiredTickCount: 2)),
      secondaryMeasureAxis: charts.NumericAxisSpec(
          showAxisLine: false,
          tickProviderSpec: charts.BasicNumericTickProviderSpec(desiredTickCount: 2)),
      barGroupingType: charts.BarGroupingType.stacked,
    );
  }

  List<charts.Series<ChartSeriesTombstoneModel, String>> _generateRandomData() {
    final random = new Random();

    final models = List.generate(5, (int index) => ChartSeriesTombstoneModel('', 5 + random.nextInt(15 - 5)));

    final List<charts.Series<ChartSeriesTombstoneModel, String>> randomTombstoneSeries = [
      charts.Series<ChartSeriesTombstoneModel, String>(
          data: models,
          measureFn: (model, _) => model.measure,
          domainFn: (model, _) => ((_!) + 1).toString(),
          id: 'tombstone',
          colorFn: (model, int? index) => charts.ColorUtil.fromDartColor(Colors.black.withOpacity(0.05)),
      )
    ];

    return randomTombstoneSeries;
  }

  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }
}