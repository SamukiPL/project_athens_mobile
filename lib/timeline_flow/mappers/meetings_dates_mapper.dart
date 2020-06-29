import 'package:project_athens/athens_core/domain/data_mapper.dart';
import 'package:project_athens/timeline_flow/data/network/response/meetings_response.dart';
import 'package:project_athens/timeline_flow/domain/meetings_date.dart';

class MeetingsDatesMapper extends DataMapper<Meeting, MeetingDate>{
  @override
  MeetingDate transform(Meeting data) => MeetingDate(data.scheduledAt);

}