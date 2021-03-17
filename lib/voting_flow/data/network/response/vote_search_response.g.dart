// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vote_search_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoteSearchResponse _$VoteSearchResponseFromJson(Map<String, dynamic> json) {
  return VoteSearchResponse(
    (json['votings'] as List)
        ?.map((e) => e == null
            ? null
            : VotingResponse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$VoteSearchResponseToJson(VoteSearchResponse instance) =>
    <String, dynamic>{
      'votings': instance.votings,
    };
