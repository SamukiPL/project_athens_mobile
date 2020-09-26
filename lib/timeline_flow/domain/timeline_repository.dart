import 'package:project_athens/athens_core/domain/result.dart';

abstract class TimelineRepository {

  Future<Result> getMeetingsDates(int cadency);

  Future<Result> getTimelineForDay(int cadency, String date);

}
