// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SavedNotification _$SavedNotificationFromJson(Map<String, dynamic> json) {
  return SavedNotification(
    json['title'] as String,
    json['body'] as String?,
    json['imgUrl'] as String?,
    json['sentTime'] == null
        ? null
        : DateTime.parse(json['sentTime'] as String),
    json['messageId'] as String?,
    json['collapseKey'] as String?,
    json['data'] as Map<String, dynamic>,
    json['type'] as String?,
    json['refId'] as String?,
    json['isRead'] as bool,
  );
}

Map<String, dynamic> _$SavedNotificationToJson(SavedNotification instance) =>
    <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
      'imgUrl': instance.imgUrl,
      'sentTime': instance.sentTime?.toIso8601String(),
      'messageId': instance.messageId,
      'collapseKey': instance.collapseKey,
      'data': instance.data,
      'type': instance.type,
      'refId': instance.refId,
      'isRead': instance.isRead,
    };
