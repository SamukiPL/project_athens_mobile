// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speeches_search_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpeechesSearchResponse _$SpeechesSearchResponseFromJson(
    Map<String, dynamic> json) {
  return SpeechesSearchResponse(
    (json['speeches'] as List<dynamic>)
        .map((e) => SpeechResponse.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$SpeechesSearchResponseToJson(
        SpeechesSearchResponse instance) =>
    <String, dynamic>{
      'speeches': instance.speeches,
    };
