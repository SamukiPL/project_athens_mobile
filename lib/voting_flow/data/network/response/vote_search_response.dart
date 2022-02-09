import 'package:json_annotation/json_annotation.dart';
import 'package:project_athens/deputies_flow/data/network/response/deputy_vote_accuracy_response.dart';

part 'vote_search_response.g.dart';

@JsonSerializable()
class VoteSearchResponse {

  final List<VoteSlimDTO> votes;

  VoteSearchResponse(this.votes);

  factory VoteSearchResponse.fromJson(Map<String, dynamic> json) => _$VoteSearchResponseFromJson(json);
  Map<String, dynamic> toJson() => _$VoteSearchResponseToJson(this);

}
