import 'package:json_annotation/json_annotation.dart';

part 'parliament_meeting_details_response.g.dart';

@JsonSerializable()
class ParliamentMeetingDetailsResponse {
  final DateTime date;
  final int cadence;
  final bool isActive;
  final String id;
  final int sessionIId;
  final ParliamentMeetingDetailsAgendaResponse agenda;
  final DateTime createAt;
  final DateTime updateAt;
  ParliamentMeetingDetailsResponse(this.date, this.cadence, this.isActive, this.id, this.sessionIId, this.agenda, this.createAt, this.updateAt);

  factory ParliamentMeetingDetailsResponse.fromJson(Map<String, dynamic> json) => _$ParliamentMeetingDetailsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ParliamentMeetingDetailsResponseToJson(this);
}

@JsonSerializable()
class ParliamentMeetingDetailsAgendaResponse {
  final List<ParliamentMeetingDetailsAgendaPointResponse> agendaPoints;

  ParliamentMeetingDetailsAgendaResponse(this.agendaPoints);

  factory ParliamentMeetingDetailsAgendaResponse.fromJson(Map<String, dynamic> json) => _$ParliamentMeetingDetailsAgendaResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ParliamentMeetingDetailsAgendaResponseToJson(this);
}

@JsonSerializable()
class ParliamentMeetingDetailsAgendaPointResponse {
  final String agenda;
  final List<String> tags;
  final bool isUE;
  final bool planned;
  final bool active;
  final int orderPoint;
  final DateTime createAt;
  final DateTime updateAt;
  final List<ParliamentMeetingDetailsAgendaPointFormResponse> forms;

  ParliamentMeetingDetailsAgendaPointResponse(this.agenda, this.tags, this.isUE, this.planned, this.active, this.orderPoint, this.createAt, this.updateAt, this.forms);

  factory ParliamentMeetingDetailsAgendaPointResponse.fromJson(Map<String, dynamic> json) => _$ParliamentMeetingDetailsAgendaPointResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ParliamentMeetingDetailsAgendaPointResponseToJson(this);
}

@JsonSerializable()
class ParliamentMeetingDetailsAgendaPointFormResponse {
  final String link;
  final String number;
  final DateTime updateAt;

  ParliamentMeetingDetailsAgendaPointFormResponse(this.link, this.number, this.updateAt);

  factory ParliamentMeetingDetailsAgendaPointFormResponse.fromJson(Map<String, dynamic> json) => _$ParliamentMeetingDetailsAgendaPointFormResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ParliamentMeetingDetailsAgendaPointFormResponseToJson(this);
}