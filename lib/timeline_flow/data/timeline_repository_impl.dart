import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/timeline_flow/data/network/response/meetings_response.dart';
import 'package:project_athens/timeline_flow/data/network/response/timeline_response.dart';
import 'package:project_athens/timeline_flow/data/network/timeline_api.dart';
import 'package:project_athens/timeline_flow/domain/meetings_date.dart';
import 'package:project_athens/athens_core/models/timeline_model.dart';
import 'package:project_athens/timeline_flow/domain/timeline_repository.dart';
import 'package:project_athens/timeline_flow/mappers/meetings_dates_mapper.dart';
import 'package:project_athens/timeline_flow/mappers/timeline_model_mapper.dart';

class TimelineRepositoryImpl implements TimelineRepository {

  final TimelineApi timelineApi;

  final TimelineModelMapper networkMapper;

  final MeetingsDatesMapper meetingsDatesMapper = MeetingsDatesMapper();

  TimelineRepositoryImpl(this.timelineApi, this.networkMapper);

  @override
  Future<Result> getMeetingsDates(int cadency) async {
    final response = await timelineApi.getMeetingsDates(cadency);
    var meetingsResponse = MeetingsResponse.fromJson(response.body);
    List<MeetingDate> resultList = meetingsDatesMapper(meetingsResponse.meetings);

    return Success<List<MeetingDate>>(resultList);
  }

  @override
  Future<Result> getTimelineForDay(int cadency, String date) async {
    final response = await timelineApi.getAllDeputies(cadency, date);
    var timelineResponse = TimelineResponse.fromJson(response.body);
    List<TimelineModel> resultList = await networkMapper(timelineResponse.events);
    resultList.sort((a, b) => a.date.compareTo(b.date));
    
    return Success<List<TimelineModel>>(resultList);
  }

}