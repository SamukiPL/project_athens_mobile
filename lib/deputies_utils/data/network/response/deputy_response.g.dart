// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deputy_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeputyResponse _$DeputyResponseFromJson(Map<String, dynamic> json) {
  return DeputyResponse(
    json['id'] as String,
    json['cadency'] as int,
    json['name'] as String,
    json['photoUrl'] as String,
    json['parliamentClub'] as String,
    json['cardId'] as int,
    json['isActive'] as bool,
  );
}

Map<String, dynamic> _$DeputyResponseToJson(DeputyResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cadency': instance.cadency,
      'isActive': instance.isActive,
      'name': instance.name,
      'parliamentClub': instance.parliamentClub,
      'photoUrl': instance.photoUrl,
      'cardId': instance.cardId,
    };
