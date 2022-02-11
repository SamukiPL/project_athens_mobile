// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vote_search_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoteSearchRequest _$VoteSearchRequestFromJson(Map<String, dynamic> json) {
  return VoteSearchRequest(
    json['limit'] as int,
    json['offset'] as int,
    json['searchPhrase'] as String,
    json['from'] as String?,
    json['to'] as String?,
    json['sort'] as String,
    json['v2'] as bool,
  );
}

Map<String, dynamic> _$VoteSearchRequestToJson(VoteSearchRequest instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'offset': instance.offset,
      'searchPhrase': instance.searchPhrase,
      'from': instance.from,
      'to': instance.to,
      'sort': instance.sort,
      'v2': instance.v2,
    };
