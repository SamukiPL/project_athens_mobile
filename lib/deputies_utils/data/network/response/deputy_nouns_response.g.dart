// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deputy_nouns_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeputyNounsResponse _$DeputyNounsResponseFromJson(Map<String, dynamic> json) {
  return DeputyNounsResponse(
    (json['nouns'] as List<dynamic>)
        .map((e) => NounTag.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$DeputyNounsResponseToJson(
        DeputyNounsResponse instance) =>
    <String, dynamic>{
      'nouns': instance.nouns,
    };
