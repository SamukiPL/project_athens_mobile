import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/timeline_flow/domain/cloud/word_model.dart';

abstract class TimelineRepository {

  Future<Result> getMeetingsDates(int cadency);

  Future<Result> getTimelineForDay(int cadency, String date);

  Future<Result<List<WordModel>>> getNounCloud(int cadency, String date);

}
