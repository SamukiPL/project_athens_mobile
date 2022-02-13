// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speech_search_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpeechSearchRequest _$SpeechSearchRequestFromJson(Map<String, dynamic> json) =>
    SpeechSearchRequest(
      json['limit'] as int,
      json['offset'] as int,
      json['searchPhrase'] as String,
      json['from'] as String?,
      json['to'] as String?,
      json['sort'] as String,
    );

Map<String, dynamic> _$SpeechSearchRequestToJson(
        SpeechSearchRequest instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'offset': instance.offset,
      'searchPhrase': instance.searchPhrase,
      'from': instance.from,
      'to': instance.to,
      'sort': instance.sort,
    };
