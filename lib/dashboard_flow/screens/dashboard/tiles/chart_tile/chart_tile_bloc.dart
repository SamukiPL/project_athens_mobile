import 'package:project_athens/athens_core/presentation/base_blocs/base_bloc.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ChartTileBloc extends BaseBloc {
  ChartTileBloc(this.seriesDataStream);

  final Stream<charts.Series> seriesDataStream;
}