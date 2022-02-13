// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meetings_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeetingsResponse _$MeetingsResponseFromJson(Map<String, dynamic> json) =>
    MeetingsResponse(
      (json['meetings'] as List<dynamic>)
          .map((e) => Meeting.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Meeting _$MeetingFromJson(Map<String, dynamic> json) => Meeting(
      json['id'] as String,
      DateTime.parse(json['scheduledAt'] as String),
      json['sessionIId'] as int,
      json['cadency'] as int,
      DateTime.parse(json['createAt'] as String),
    );
