// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parliament_club_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParliamentClubResponse _$ParliamentClubResponseFromJson(
    Map<String, dynamic> json) {
  return ParliamentClubResponse(
    (json['parliamentClubs'] as List)
        ?.map((e) => e == null
            ? null
            : ParliamentClubBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ParliamentClubResponseToJson(
        ParliamentClubResponse instance) =>
    <String, dynamic>{
      'parliamentClubs': instance.parliamentClubs,
    };

ParliamentClubBean _$ParliamentClubBeanFromJson(Map<String, dynamic> json) {
  return ParliamentClubBean(
    json['id'] as String,
    json['name'] as String,
    json['shortName'] as String,
    json['imageSrc'] as String,
    json['cadency'] as int,
    json['updateAt'] == null
        ? null
        : DateTime.parse(json['updateAt'] as String),
    json['createAt'] == null
        ? null
        : DateTime.parse(json['createAt'] as String),
  );
}

Map<String, dynamic> _$ParliamentClubBeanToJson(ParliamentClubBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'shortName': instance.shortName,
      'imageSrc': instance.imageSrc,
      'cadency': instance.cadency,
      'updateAt': instance.updateAt?.toIso8601String(),
      'createAt': instance.createAt?.toIso8601String(),
    };
