// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timeline_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimelineResponse _$TimelineResponseFromJson(Map<String, dynamic> json) {
  return TimelineResponse(
    (json['events'] as List)
        ?.map(
            (e) => e == null ? null : Event.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
