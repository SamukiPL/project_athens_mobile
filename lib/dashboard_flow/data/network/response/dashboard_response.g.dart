// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardResponse _$DashboardResponseFromJson(Map<String, dynamic> json) =>
    DashboardResponse(
      json['meeting'] == null
          ? null
          : DashboardNearestMeetingResponse.fromJson(
              json['meeting'] as Map<String, dynamic>),
      json['absentVote'] == null
          ? null
          : DashboardAbsentVoteCounterResponse.fromJson(
              json['absentVote'] as Map<String, dynamic>),
      json['speechesCounter'] == null
          ? null
          : DashboardSpeechesCounterResponse.fromJson(
              json['speechesCounter'] as Map<String, dynamic>),
      json['absentVotePerYear'] == null
          ? null
          : DashboardCounterPerYearResponse.fromJson(
              json['absentVotePerYear'] as Map<String, dynamic>),
      json['speechesCounterPerYear'] == null
          ? null
          : DashboardCounterPerYearResponse.fromJson(
              json['speechesCounterPerYear'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DashboardResponseToJson(DashboardResponse instance) =>
    <String, dynamic>{
      'meeting': instance.meeting,
      'absentVote': instance.absentVote,
      'speechesCounter': instance.speechesCounter,
      'absentVotePerYear': instance.absentVotePerYear,
      'speechesCounterPerYear': instance.speechesCounterPerYear,
    };

DashboardNearestMeetingResponse _$DashboardNearestMeetingResponseFromJson(
        Map<String, dynamic> json) =>
    DashboardNearestMeetingResponse(
      DateTime.parse(json['nearestPastMeeting'] as String),
      DateTime.parse(json['nearestMeeting'] as String),
      json['nearestPastMeetingId'] as String,
      json['nearestMeetingId'] as String,
    );

Map<String, dynamic> _$DashboardNearestMeetingResponseToJson(
        DashboardNearestMeetingResponse instance) =>
    <String, dynamic>{
      'nearestPastMeeting': instance.nearestPastMeeting.toIso8601String(),
      'nearestMeeting': instance.nearestMeeting.toIso8601String(),
      'nearestPastMeetingId': instance.nearestPastMeetingId,
      'nearestMeetingId': instance.nearestMeetingId,
    };

DashboardAbsentVoteCounterResponse _$DashboardAbsentVoteCounterResponseFromJson(
        Map<String, dynamic> json) =>
    DashboardAbsentVoteCounterResponse(
      (json['perDeputy'] as List<dynamic>)
          .map((e) => DashboardAbsentVoteCounterDeputy.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      json['updateAt'] == null
          ? null
          : DateTime.parse(json['updateAt'] as String),
    );

Map<String, dynamic> _$DashboardAbsentVoteCounterResponseToJson(
        DashboardAbsentVoteCounterResponse instance) =>
    <String, dynamic>{
      'perDeputy': instance.perDeputy,
      'updateAt': instance.updateAt?.toIso8601String(),
    };

DashboardAbsentVoteCounterDeputy _$DashboardAbsentVoteCounterDeputyFromJson(
        Map<String, dynamic> json) =>
    DashboardAbsentVoteCounterDeputy(
      json['subscribedDeputyId'] as String,
      json['cardId'] as int,
      json['absentVote'],
    );

Map<String, dynamic> _$DashboardAbsentVoteCounterDeputyToJson(
        DashboardAbsentVoteCounterDeputy instance) =>
    <String, dynamic>{
      'subscribedDeputyId': instance.subscribedDeputyId,
      'cardId': instance.cardId,
      'absentVote': instance.absentVote,
    };

DashboardSpeechesCounterResponse _$DashboardSpeechesCounterResponseFromJson(
        Map<String, dynamic> json) =>
    DashboardSpeechesCounterResponse(
      (json['perDeputy'] as List<dynamic>)
          .map((e) => DashboardSpeechesCounterDeputy.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      json['updateAt'] == null
          ? null
          : DateTime.parse(json['updateAt'] as String),
    );

Map<String, dynamic> _$DashboardSpeechesCounterResponseToJson(
        DashboardSpeechesCounterResponse instance) =>
    <String, dynamic>{
      'perDeputy': instance.perDeputy,
      'updateAt': instance.updateAt?.toIso8601String(),
    };

DashboardSpeechesCounterDeputy _$DashboardSpeechesCounterDeputyFromJson(
        Map<String, dynamic> json) =>
    DashboardSpeechesCounterDeputy(
      json['subscribedDeputyId'] as String,
      json['cardId'] as int,
      json['speechesCounter'],
    );

Map<String, dynamic> _$DashboardSpeechesCounterDeputyToJson(
        DashboardSpeechesCounterDeputy instance) =>
    <String, dynamic>{
      'subscribedDeputyId': instance.subscribedDeputyId,
      'cardId': instance.cardId,
      'speechesCounter': instance.speechesCounter,
    };

DashboardCounterPerYearResponse _$DashboardCounterPerYearResponseFromJson(
        Map<String, dynamic> json) =>
    DashboardCounterPerYearResponse(
      (json['perDeputy'] as List<dynamic>)
          .map(
              (e) => DashboardDeputyCounter.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['updateAt'] == null
          ? null
          : DateTime.parse(json['updateAt'] as String),
    );

Map<String, dynamic> _$DashboardCounterPerYearResponseToJson(
        DashboardCounterPerYearResponse instance) =>
    <String, dynamic>{
      'perDeputy': instance.perDeputy,
      'updateAt': instance.updateAt?.toIso8601String(),
    };

DashboardDeputyCounter _$DashboardDeputyCounterFromJson(
        Map<String, dynamic> json) =>
    DashboardDeputyCounter(
      json['subscribedDeputyId'] as String,
      (json['perYear'] as List<dynamic>)
          .map((e) =>
              DashboardDeputyCounterPerYear.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DashboardDeputyCounterToJson(
        DashboardDeputyCounter instance) =>
    <String, dynamic>{
      'subscribedDeputyId': instance.subscribedDeputyId,
      'perYear': instance.perYear,
    };

DashboardDeputyCounterPerYear _$DashboardDeputyCounterPerYearFromJson(
        Map<String, dynamic> json) =>
    DashboardDeputyCounterPerYear(
      json['year'] as int,
      json['counter'] as int,
    );

Map<String, dynamic> _$DashboardDeputyCounterPerYearToJson(
        DashboardDeputyCounterPerYear instance) =>
    <String, dynamic>{
      'year': instance.year,
      'counter': instance.counter,
    };
