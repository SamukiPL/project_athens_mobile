import 'package:athens_core/domain/result.dart';

abstract class TimelineRepository {

  Future<Result> getTimelineForDay(int cadency, String date);

}
