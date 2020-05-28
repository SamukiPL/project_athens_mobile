import 'package:json_annotation/json_annotation.dart';
import 'package:timeline_flow/data/network/response/timeline_response.dart';

part 'voting.g.dart';

@JsonSerializable()
class Voting implements TimelineItem{
  final VotingNumbers votingNumbers;
  final DateTime votedAt;
  final DateTime actualVotedAt;
  final DateTime createAt;
  final int cadency;
  final dynamic orderPoint;
  final int sessionIId;
  final int votingIId;
  final String votingUniqueId;
  final String topic;
  final List<Votes> votes;
  final int votingType;
  final String id;

  Voting(this.votingNumbers, this.votedAt, this.actualVotedAt, this.createAt, this.cadency, this.orderPoint, this.sessionIId, this.votingIId, this.votingUniqueId, this.topic, this.votes, this.votingType, this.id);

  factory Voting.fromJson(Map<String, dynamic> json) => _$VotingFromJson(json);
  Map<String, dynamic> toJson() => _$VotingToJson(this);
}

@JsonSerializable()
class Votes {
  final int type;
  final String cadencyDeputy;

  Votes(this.type, this.cadencyDeputy);

  factory Votes.fromJson(Map<String, dynamic> json) => _$VotesFromJson(json);
  Map<String, dynamic> toJson() => _$VotesToJson(this);
}

@JsonSerializable()
class VotingNumbers {
  final int inFavor;
  final int against;
  final int hold;
  final int absent;

  VotingNumbers(this.inFavor, this.against, this.hold, this.absent);

  factory VotingNumbers.fromJson(Map<String, dynamic> json) => _$VotingNumbersFromJson(json);
  Map<String, dynamic> toJson() => _$VotingNumbersToJson(this);
}