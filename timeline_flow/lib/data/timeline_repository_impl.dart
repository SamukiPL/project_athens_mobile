import 'package:athens_core/domain/result.dart';
import 'package:timeline_flow/data/network/response/timeline_response.dart';
import 'package:timeline_flow/data/network/timeline_api.dart';
import 'package:timeline_flow/domain/timeline_model.dart';
import 'package:timeline_flow/domain/timeline_repository.dart';
import 'package:timeline_flow/mappers/timeline_model_mapper.dart';

class TimelineRepositoryImpl implements TimelineRepository {

  final TimelineApi timelineApi;

  final TimelineModelMapper networkMapper;

  TimelineRepositoryImpl(this.timelineApi, this.networkMapper);

  @override
  Future<Result> getTimelineForDay(int cadency, String date) async {
    final response = await timelineApi.getAllDeputies(cadency, date);
    var timelineResponse = TimelineResponse.fromJson(response.body);
    List<TimelineModel> resultList = networkMapper(timelineResponse.events);
    resultList.sort((a, b) => a.date.compareTo(b.date));
    
    return Success<List<TimelineModel>>(resultList);
  }

}