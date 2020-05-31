// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deputy_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeputyRequest _$DeputyRequestFromJson(Map<String, dynamic> json) {
  return DeputyRequest(
    (json['deputies'] as List)
        ?.map((e) =>
            e == null ? null : Deputy.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DeputyRequestToJson(DeputyRequest instance) =>
    <String, dynamic>{
      'deputies': instance.deputies,
    };

Deputy _$DeputyFromJson(Map<String, dynamic> json) {
  return Deputy(
    json['deputyId'] as String,
    json['notifications'] == null
        ? null
        : Notifications.fromJson(json['notifications'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$DeputyToJson(Deputy instance) => <String, dynamic>{
      'deputyId': instance.deputyId,
      'notifications': instance.notifications,
    };

Notifications _$NotificationsFromJson(Map<String, dynamic> json) {
  return Notifications(
    json['vote'] as bool,
    json['speech'] as bool,
    json['interpolation'] as bool,
  );
}

Map<String, dynamic> _$NotificationsToJson(Notifications instance) =>
    <String, dynamic>{
      'vote': instance.vote,
      'speech': instance.speech,
      'interpolation': instance.interpolation,
    };
