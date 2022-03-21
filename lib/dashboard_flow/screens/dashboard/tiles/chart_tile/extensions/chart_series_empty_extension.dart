import 'package:charts_flutter/flutter.dart';

extension SeriesEmptyExtension on List<Series> {
  bool get hasNoData => this.isEmpty || this[0].data.isEmpty;
}
