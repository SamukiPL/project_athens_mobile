// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'noun_cloud_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NounTag _$NounTagFromJson(Map<String, dynamic> json) {
  return NounTag(
    json['key'] as String,
    json['hits'] as int,
  );
}

Map<String, dynamic> _$NounTagToJson(NounTag instance) => <String, dynamic>{
      'key': instance.key,
      'hits': instance.hits,
    };

NounCloudResponse _$NounCloudResponseFromJson(Map<String, dynamic> json) {
  return NounCloudResponse(
    json['id'] as String,
    json['createAt'] == null
        ? null
        : DateTime.parse(json['createAt'] as String),
    json['updateAt'] == null
        ? null
        : DateTime.parse(json['updateAt'] as String),
    json['cadency'] as int,
    json['scheduledAt'] == null
        ? null
        : DateTime.parse(json['scheduledAt'] as String),
    json['sessionIId'] as int,
    (json['nouns'] as List)
        ?.map((e) =>
            e == null ? null : NounTag.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$NounCloudResponseToJson(NounCloudResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createAt': instance.createAt?.toIso8601String(),
      'updateAt': instance.updateAt?.toIso8601String(),
      'cadency': instance.cadency,
      'scheduledAt': instance.scheduledAt?.toIso8601String(),
      'sessionIId': instance.sessionIId,
      'nouns': instance.nouns,
    };
