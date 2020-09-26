// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meetings_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeetingsResponse _$MeetingsResponseFromJson(Map<String, dynamic> json) {
  return MeetingsResponse(
    (json['meetings'] as List)
        ?.map((e) =>
            e == null ? null : Meeting.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Meeting _$MeetingFromJson(Map<String, dynamic> json) {
  return Meeting(
    json['id'] as String,
    json['scheduledAt'] == null
        ? null
        : DateTime.parse(json['scheduledAt'] as String),
    json['sessionIId'] as int,
    json['cadency'] as int,
    json['createAt'] == null
        ? null
        : DateTime.parse(json['createAt'] as String),
  );
}
