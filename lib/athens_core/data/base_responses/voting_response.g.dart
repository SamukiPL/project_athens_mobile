// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voting_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VotingResponse _$VotingResponseFromJson(Map<String, dynamic> json) =>
    VotingResponse(
      VotingNumbers.fromJson(json['votingNumbers'] as Map<String, dynamic>),
      DateTime.parse(json['votedAt'] as String),
      DateTime.parse(json['actualVotedAt'] as String),
      DateTime.parse(json['createAt'] as String),
      json['cadency'] as int,
      json['orderPoint'] as int?,
      json['sessionIId'] as int,
      json['votingIId'] as int,
      json['votingUniqueId'] as String,
      json['topic'] as String,
      (json['votes'] as List<dynamic>)
          .map((e) => Votes.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['votingType'] as int,
      json['id'] as String,
      json['absoluteMajority'] as int,
      json['qualifyingMajority'] as int,
      (json['parliamentClubVotingNumbers'] as List<dynamic>)
          .map((e) =>
              ParliamentClubVotingNumbers.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['deputyVoteType'] as int?,
      json['updateAt'] == null
          ? null
          : DateTime.parse(json['updateAt'] as String),
    );

Map<String, dynamic> _$VotingResponseToJson(VotingResponse instance) =>
    <String, dynamic>{
      'votingNumbers': instance.votingNumbers,
      'votedAt': instance.votedAt.toIso8601String(),
      'actualVotedAt': instance.actualVotedAt.toIso8601String(),
      'createAt': instance.createAt.toIso8601String(),
      'updateAt': instance.updateAt?.toIso8601String(),
      'cadency': instance.cadency,
      'orderPoint': instance.orderPoint,
      'sessionIId': instance.sessionIId,
      'votingIId': instance.votingIId,
      'votingUniqueId': instance.votingUniqueId,
      'topic': instance.topic,
      'votes': instance.votes,
      'votingType': instance.votingType,
      'id': instance.id,
      'absoluteMajority': instance.absoluteMajority,
      'qualifyingMajority': instance.qualifyingMajority,
      'parliamentClubVotingNumbers': instance.parliamentClubVotingNumbers,
      'deputyVoteType': instance.deputyVoteType,
    };

Votes _$VotesFromJson(Map<String, dynamic> json) => Votes(
      json['type'] as int,
      json['cadencyDeputy'] as String,
    );

Map<String, dynamic> _$VotesToJson(Votes instance) => <String, dynamic>{
      'type': instance.type,
      'cadencyDeputy': instance.cadencyDeputy,
    };

VotingNumbers _$VotingNumbersFromJson(Map<String, dynamic> json) =>
    VotingNumbers(
      json['inFavor'] as int,
      json['against'] as int,
      json['hold'] as int,
      json['absent'] as int,
    );

Map<String, dynamic> _$VotingNumbersToJson(VotingNumbers instance) =>
    <String, dynamic>{
      'inFavor': instance.inFavor,
      'against': instance.against,
      'hold': instance.hold,
      'absent': instance.absent,
    };

ParliamentClubVotingNumbers _$ParliamentClubVotingNumbersFromJson(
        Map<String, dynamic> json) =>
    ParliamentClubVotingNumbers(
      json['inFavor'] as int,
      json['against'] as int,
      json['hold'] as int,
      json['absent'] as int,
      json['totalDeputies'] as int,
      json['actualVoted'] as int,
      json['parliamentClub'] as String,
    );

Map<String, dynamic> _$ParliamentClubVotingNumbersToJson(
        ParliamentClubVotingNumbers instance) =>
    <String, dynamic>{
      'inFavor': instance.inFavor,
      'against': instance.against,
      'hold': instance.hold,
      'absent': instance.absent,
      'totalDeputies': instance.totalDeputies,
      'actualVoted': instance.actualVoted,
      'parliamentClub': instance.parliamentClub,
    };
