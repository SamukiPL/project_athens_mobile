import 'package:json_annotation/json_annotation.dart';
import 'package:project_athens/athens_core/data/base_responses/timeline_response.dart';
import 'package:project_athens/athens_core/data/base_responses/voting_response.dart';
import 'package:project_athens/athens_core/models/voting_model.dart';

part 'deputy_vote_accuracy_response.g.dart';

@JsonSerializable()
class DeputyVoteAccuracyResponse {
  final List<VoteSlimDTO> votes;

  DeputyVoteAccuracyResponse(this.votes);

  factory DeputyVoteAccuracyResponse.fromJson(Map<String, dynamic> json) => _$DeputyVoteAccuracyResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DeputyVoteAccuracyResponseToJson(this);
}

@JsonSerializable()
class VoteSlimDTO extends TimelineItem {
  final String id;
  final String agenda;
  final VotingType type;
  final DateTime voteAt;
  final VoteSlimVotingNumbersDTO voteNumbers;
  final int? qualifyingMajority;
  final int? absoluteMajority;
  final List<VoteSlimClubMajorityDTO> clubsMajority;
  final List<VoteSlimDeputyMajorityVoteDTO> deputiesVoteType;
  final int? orderPoint;

  VoteSlimDTO(this.id, this.agenda, this.type, this.voteAt, this.voteNumbers, this.clubsMajority, this.deputiesVoteType, this.qualifyingMajority, this.absoluteMajority, this.orderPoint);

  factory VoteSlimDTO.fromJson(Map<String, dynamic> json) => _$VoteSlimDTOFromJson(json);
  Map<String, dynamic> toJson() => _$VoteSlimDTOToJson(this);
}

@JsonSerializable()
class VoteSlimClubMajorityDTO {
  final String parliamentClub;
  final VoteType voteMajority;
  final List<int> deputyCardNumbers;

  VoteSlimClubMajorityDTO(this.parliamentClub, this.voteMajority, this.deputyCardNumbers);

  factory VoteSlimClubMajorityDTO.fromJson(Map<String, dynamic> json) => _$VoteSlimClubMajorityDTOFromJson(json);
  Map<String, dynamic> toJson() => _$VoteSlimClubMajorityDTOToJson(this);
}

@JsonSerializable()
class VoteSlimDeputyMajorityVoteDTO {
  final String cadencyDeputy;
  final VoteType voteType;

  VoteSlimDeputyMajorityVoteDTO(this.cadencyDeputy, this.voteType);

  factory VoteSlimDeputyMajorityVoteDTO.fromJson(Map<String, dynamic> json) => _$VoteSlimDeputyMajorityVoteDTOFromJson(json);
  Map<String, dynamic> toJson() => _$VoteSlimDeputyMajorityVoteDTOToJson(this);
}

@JsonSerializable()
class VoteSlimVotingNumbersDTO {
  final int inFavor;
  final int against;
  final int hold;
  final int absent;

  VoteSlimVotingNumbersDTO(this.inFavor, this.against, this.hold, this.absent);

  factory VoteSlimVotingNumbersDTO.fromJson(Map<String, dynamic> json) => _$VoteSlimVotingNumbersDTOFromJson(json);
  Map<String, dynamic> toJson() => _$VoteSlimVotingNumbersDTOToJson(this);
}
