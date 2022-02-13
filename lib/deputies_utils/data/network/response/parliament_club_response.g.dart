// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parliament_club_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParliamentClubResponse _$ParliamentClubResponseFromJson(
        Map<String, dynamic> json) =>
    ParliamentClubResponse(
      (json['parliamentClubs'] as List<dynamic>)
          .map((e) => ParliamentClubBean.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ParliamentClubResponseToJson(
        ParliamentClubResponse instance) =>
    <String, dynamic>{
      'parliamentClubs': instance.parliamentClubs,
    };

ParliamentClubBean _$ParliamentClubBeanFromJson(Map<String, dynamic> json) =>
    ParliamentClubBean(
      json['id'] as String,
      json['name'] as String,
      json['shortName'] as String,
      json['imageSrc'] as String,
      json['cadency'] as int,
      DateTime.parse(json['updateAt'] as String),
      DateTime.parse(json['createAt'] as String),
    );

Map<String, dynamic> _$ParliamentClubBeanToJson(ParliamentClubBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'shortName': instance.shortName,
      'imageSrc': instance.imageSrc,
      'cadency': instance.cadency,
      'updateAt': instance.updateAt.toIso8601String(),
      'createAt': instance.createAt.toIso8601String(),
    };
