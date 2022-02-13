// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timeline_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimelineResponse _$TimelineResponseFromJson(Map<String, dynamic> json) =>
    TimelineResponse(
      (json['events'] as List<dynamic>)
          .map((e) => Event.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
