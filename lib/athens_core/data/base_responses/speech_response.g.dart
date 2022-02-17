// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speech_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpeechResponse _$SpeechResponseFromJson(Map<String, dynamic> json) =>
    SpeechResponse(
      json['agenda'] == null
          ? null
          : Agenda.fromJson(json['agenda'] as Map<String, dynamic>),
      CisInfo.fromJson(json['cisInfo'] as Map<String, dynamic>),
      DateTime.parse(json['createAt'] as String),
      json['id'] as String,
      json['deputyCardIdentifier'] as int?,
      json['fileName'] as String?,
      json['videoDownloadUrl'] as String,
      json['length'] as int?,
      json['personName'] as String,
      json['cadencyDeputy'] as String?,
      json['parliamentClub'] as String?,
      json['cadency'] as int,
      json['rangeId'] as String?,
      json['previousPersonSpeech'] == null
          ? null
          : PersonSpeech.fromJson(
              json['previousPersonSpeech'] as Map<String, dynamic>),
      json['nextPersonSpeech'] == null
          ? null
          : PersonSpeech.fromJson(
              json['nextPersonSpeech'] as Map<String, dynamic>),
      DateTime.parse(json['updateAt'] as String),
      json['viewed'] as bool?,
    );

Map<String, dynamic> _$SpeechResponseToJson(SpeechResponse instance) =>
    <String, dynamic>{
      'agenda': instance.agenda,
      'cisInfo': instance.cisInfo,
      'createAt': instance.createAt.toIso8601String(),
      'updateAt': instance.updateAt.toIso8601String(),
      'id': instance.id,
      'deputyCardIdentifier': instance.deputyCardIdentifier,
      'fileName': instance.fileName,
      'videoDownloadUrl': instance.videoDownloadUrl,
      'length': instance.length,
      'personName': instance.personName,
      'cadencyDeputy': instance.cadencyDeputy,
      'parliamentClub': instance.parliamentClub,
      'cadency': instance.cadency,
      'rangeId': instance.rangeId,
      'previousPersonSpeech': instance.previousPersonSpeech,
      'nextPersonSpeech': instance.nextPersonSpeech,
      'viewed': instance.viewed,
    };

Agenda _$AgendaFromJson(Map<String, dynamic> json) => Agenda(
      json['eventDateTime'] == null
          ? null
          : DateTime.parse(json['eventDateTime'] as String),
      json['msgDateTime'] == null
          ? null
          : DateTime.parse(json['msgDateTime'] as String),
      json['refId'] as String?,
      json['rangeid'] as String?,
      json['title'] as String,
    );

Map<String, dynamic> _$AgendaToJson(Agenda instance) => <String, dynamic>{
      'eventDateTime': instance.eventDateTime?.toIso8601String(),
      'msgDateTime': instance.msgDateTime?.toIso8601String(),
      'refId': instance.refId,
      'rangeid': instance.rangeid,
      'title': instance.title,
    };

CisInfo _$CisInfoFromJson(Map<String, dynamic> json) => CisInfo(
      json['person'] == null
          ? null
          : Person.fromJson(json['person'] as Map<String, dynamic>),
      DateTime.parse(json['eventDateTime'] as String),
      json['msgDateTime'] == null
          ? null
          : DateTime.parse(json['msgDateTime'] as String),
      json['rangeid'] as String?,
      json['refId'] as String?,
    );

Map<String, dynamic> _$CisInfoToJson(CisInfo instance) => <String, dynamic>{
      'person': instance.person,
      'eventDateTime': instance.eventDateTime.toIso8601String(),
      'msgDateTime': instance.msgDateTime?.toIso8601String(),
      'rangeid': instance.rangeid,
      'refId': instance.refId,
    };

Person _$PersonFromJson(Map<String, dynamic> json) => Person(
      json['name'] as String,
      json['surname'] as String,
      $enumDecodeNullable(_$GenderEnumMap, json['gender']),
      json['function'] as String?,
      json['other'] as String?,
      json['deputyCardNumber'] as int?,
      json['termOfficeNumber'] as int?,
    );

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'name': instance.name,
      'surname': instance.surname,
      'gender': _$GenderEnumMap[instance.gender],
      'function': instance.function,
      'other': instance.other,
      'deputyCardNumber': instance.deputyCardNumber,
      'termOfficeNumber': instance.termOfficeNumber,
    };

const _$GenderEnumMap = {
  Gender.MALE: 'male',
  Gender.FEMALE: 'female',
};

PersonSpeech _$PersonSpeechFromJson(Map<String, dynamic> json) => PersonSpeech(
      json['deputyCardId'] as int?,
      json['fullName'] as String?,
      json['speechId'] as String,
    );

Map<String, dynamic> _$PersonSpeechToJson(PersonSpeech instance) =>
    <String, dynamic>{
      'deputyCardId': instance.deputyCardId,
      'fullName': instance.fullName,
      'speechId': instance.speechId,
    };
