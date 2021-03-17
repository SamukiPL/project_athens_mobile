import 'package:json_annotation/json_annotation.dart';
import 'package:project_athens/athens_core/data/base_responses/voting_response.dart';

part 'vote_search_response.g.dart';

@JsonSerializable()
class VoteSearchResponse {

  final List<VotingResponse> votings;

  VoteSearchResponse(this.votings);

  factory VoteSearchResponse.fromJson(Map<String, dynamic> json) => _$VoteSearchResponseFromJson(json);
  Map<String, dynamic> toJson() => _$VoteSearchResponseToJson(this);

}