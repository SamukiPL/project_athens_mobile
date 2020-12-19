import 'package:json_annotation/json_annotation.dart';
import 'package:project_athens/athens_core/data/base_responses/timeline_response.dart';

part 'voting_response.g.dart';

@JsonSerializable()
class VotingResponse implements TimelineItem {
  final VotingNumbers votingNumbers;
  final DateTime votedAt;
  final DateTime actualVotedAt;
  final DateTime createAt;
  final int cadency;
  final int orderPoint;
  final int sessionIId;
  final int votingIId;
  final String votingUniqueId;
  final String topic;
  final List<Votes> votes;
  final VotingType votingType;
  final String id;
  final int absoluteMajority;
  final int qualifyingMajority;
  final List<ParliamentClubVotingNumbers> parliamentClubVotingNumbers;

  int get inFavor => votingNumbers.inFavor;
  int get against => votingNumbers.against;
  int get hold => votingNumbers.hold;
  int get absent => votingNumbers.absent;

  VotingResponse(
      this.votingNumbers,
      this.votedAt,
      this.actualVotedAt,
      this.createAt,
      this.cadency,
      this.orderPoint,
      this.sessionIId,
      this.votingIId,
      this.votingUniqueId,
      this.topic,
      this.votes,
      this.votingType,
      this.id,
      this.absoluteMajority,
      this.qualifyingMajority,
      this.parliamentClubVotingNumbers);

  factory VotingResponse.fromJson(Map<String, dynamic> json) => _$VotingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VotingResponseToJson(this);
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

  factory VotingNumbers.fromJson(Map<String, dynamic> json) =>
      _$VotingNumbersFromJson(json);

  Map<String, dynamic> toJson() => _$VotingNumbersToJson(this);
}

@JsonSerializable()
class ParliamentClubVotingNumbers {
  final int inFavor;
  final int against;
  final int hold;
  final int absent;
  final int totalDeputies;
  final int actualVoted;
  final String parliamentClub;

  ParliamentClubVotingNumbers(this.inFavor, this.against, this.hold, this.absent, this.totalDeputies, this.actualVoted, this.parliamentClub);

  factory ParliamentClubVotingNumbers.fromJson(Map<String, dynamic> json) =>
      _$ParliamentClubVotingNumbersFromJson(json);

  Map<String, dynamic> toJson() => _$ParliamentClubVotingNumbersToJson(this);
}

enum VotingType {
  @JsonValue(0)
  RESOLUTION_PROJECT,
  @JsonValue(1)
  LAW_PROJECT,
  @JsonValue(2)
  BREAK,
  @JsonValue(3)
  QUORUM,
  @JsonValue(4)
  REPORT,
  @JsonValue(5)
  VOTE_OF_NO_CONFIDENCE,
  @JsonValue(6)
  COMPLETION_OF_AGENDA,
  @JsonValue(7)
  SHORTENING_DEADLINE,
  @JsonValue(8)
  CHANGE_COMISSION_MEMBERS,
  @JsonValue(9)
  VOTE_FOR_PROPOSAL,
  /// Pkt 19. porz. dzien. Wybór sędziów Trybunału Konstytucyjnego - głosowanie nad wyborem pana Jakuba Steliny na stanowisko sędziego Trybunału Konstytucyjnego
  @JsonValue(10)
  PERSON_VOTE,
  @JsonValue(999)
  UNKNOWN
}
