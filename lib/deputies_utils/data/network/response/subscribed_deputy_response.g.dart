// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscribed_deputy_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscribedDeputyResponse _$SubscribedDeputyResponseFromJson(
    Map<String, dynamic> json) {
  return SubscribedDeputyResponse(
    json['id'] as String,
    json['createAt'] == null
        ? null
        : DateTime.parse(json['createAt'] as String),
    json['cadency'] as int,
    json['isPrimary'] as bool,
    json['cadencyDeputyId'] as String,
    json['notifications'] == null
        ? null
        : Notifications.fromJson(json['notifications'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SubscribedDeputyResponseToJson(
        SubscribedDeputyResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createAt': instance.createAt?.toIso8601String(),
      'cadency': instance.cadency,
      'isPrimary': instance.isPrimary,
      'cadencyDeputyId': instance.cadencyDeputyId,
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
