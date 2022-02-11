import 'package:project_athens/athens_core/data/word_model/word_model.dart';
import 'package:project_athens/athens_core/domain/result.dart';

abstract class TimelineRepository {

  Future<Result> getMeetingsDates();

  Future<Result> getTimelineForDay(String date);

  Future<Result<List<WordModel>>> getNounCloud(String date);

}
