
import 'package:json_annotation/json_annotation.dart';

part 'meetings_response.g.dart';

@JsonSerializable(createToJson: false)
class MeetingsResponse {
  final List<Meeting> meetings;

  MeetingsResponse(this.meetings);

  factory MeetingsResponse.fromJson(Map<String, dynamic> json) => _$MeetingsResponseFromJson(json);
}

@JsonSerializable(createToJson: false)
class Meeting {
  final String id;
  final DateTime scheduledAt;
  final int sessionIId;
  final int cadency;
  final DateTime createAt;

  Meeting(this.id, this.scheduledAt, this.sessionIId, this.cadency, this.createAt);

  factory Meeting.fromJson(Map<String, dynamic> json) => _$MeetingFromJson(json);
}