// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vote_search_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoteSearchResponse _$VoteSearchResponseFromJson(Map<String, dynamic> json) =>
    VoteSearchResponse(
      (json['votes'] as List<dynamic>)
          .map((e) => VoteSlimDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VoteSearchResponseToJson(VoteSearchResponse instance) =>
    <String, dynamic>{
      'votes': instance.votes,
    };
