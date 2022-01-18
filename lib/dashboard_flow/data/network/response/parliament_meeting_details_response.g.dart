// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parliament_meeting_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParliamentMeetingDetailsResponse _$ParliamentMeetingDetailsResponseFromJson(
    Map<String, dynamic> json) {
  return ParliamentMeetingDetailsResponse(
    DateTime.parse(json['date'] as String),
    json['cadence'] as int,
    json['isActive'] as bool,
    json['id'] as String,
    json['sessionIId'] as int,
    ParliamentMeetingDetailsAgendaResponse.fromJson(
        json['agenda'] as Map<String, dynamic>),
    DateTime.parse(json['createAt'] as String),
    DateTime.parse(json['updateAt'] as String),
  );
}

Map<String, dynamic> _$ParliamentMeetingDetailsResponseToJson(
        ParliamentMeetingDetailsResponse instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'cadence': instance.cadence,
      'isActive': instance.isActive,
      'id': instance.id,
      'sessionIId': instance.sessionIId,
      'agenda': instance.agenda,
      'createAt': instance.createAt.toIso8601String(),
      'updateAt': instance.updateAt.toIso8601String(),
    };

ParliamentMeetingDetailsAgendaResponse
    _$ParliamentMeetingDetailsAgendaResponseFromJson(
        Map<String, dynamic> json) {
  return ParliamentMeetingDetailsAgendaResponse(
    (json['agendaPoints'] as List<dynamic>)
        .map((e) => ParliamentMeetingDetailsAgendaPointResponse.fromJson(
            e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ParliamentMeetingDetailsAgendaResponseToJson(
        ParliamentMeetingDetailsAgendaResponse instance) =>
    <String, dynamic>{
      'agendaPoints': instance.agendaPoints,
    };

ParliamentMeetingDetailsAgendaPointResponse
    _$ParliamentMeetingDetailsAgendaPointResponseFromJson(
        Map<String, dynamic> json) {
  return ParliamentMeetingDetailsAgendaPointResponse(
    json['agenda'] as String,
    (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
    json['isUE'] as bool,
    json['planned'] as bool,
    json['active'] as bool,
    json['orderPoint'] as int,
    DateTime.parse(json['createAt'] as String),
    DateTime.parse(json['updateAt'] as String),
    (json['forms'] as List<dynamic>)
        .map((e) => ParliamentMeetingDetailsAgendaPointFormResponse.fromJson(
            e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ParliamentMeetingDetailsAgendaPointResponseToJson(
        ParliamentMeetingDetailsAgendaPointResponse instance) =>
    <String, dynamic>{
      'agenda': instance.agenda,
      'tags': instance.tags,
      'isUE': instance.isUE,
      'planned': instance.planned,
      'active': instance.active,
      'orderPoint': instance.orderPoint,
      'createAt': instance.createAt.toIso8601String(),
      'updateAt': instance.updateAt.toIso8601String(),
      'forms': instance.forms,
    };

ParliamentMeetingDetailsAgendaPointFormResponse
    _$ParliamentMeetingDetailsAgendaPointFormResponseFromJson(
        Map<String, dynamic> json) {
  return ParliamentMeetingDetailsAgendaPointFormResponse(
    json['link'] as String,
    json['number'] as String,
    DateTime.parse(json['updateAt'] as String),
  );
}

Map<String, dynamic> _$ParliamentMeetingDetailsAgendaPointFormResponseToJson(
        ParliamentMeetingDetailsAgendaPointFormResponse instance) =>
    <String, dynamic>{
      'link': instance.link,
      'number': instance.number,
      'updateAt': instance.updateAt.toIso8601String(),
    };
