import 'package:athens_core/domain/list/base_params.dart';

class TimelineParameters implements BaseParams {
  final int cadency;
  final String date;

  TimelineParameters(this.cadency, this.date);
}