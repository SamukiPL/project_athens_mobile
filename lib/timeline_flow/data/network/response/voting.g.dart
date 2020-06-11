// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Voting _$VotingFromJson(Map<String, dynamic> json) {
  return Voting(
    json['votingNumbers'] == null
        ? null
        : VotingNumbers.fromJson(json['votingNumbers'] as Map<String, dynamic>),
    json['votedAt'] == null ? null : DateTime.parse(json['votedAt'] as String),
    json['actualVotedAt'] == null
        ? null
        : DateTime.parse(json['actualVotedAt'] as String),
    json['createAt'] == null
        ? null
        : DateTime.parse(json['createAt'] as String),
    json['cadency'] as int,
    json['orderPoint'],
    json['sessionIId'] as int,
    json['votingIId'] as int,
    json['votingUniqueId'] as String,
    json['topic'] as String,
    (json['votes'] as List)
        ?.map(
            (e) => e == null ? null : Votes.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['votingType'] as int,
    json['id'] as String,
  );
}

Map<String, dynamic> _$VotingToJson(Voting instance) => <String, dynamic>{
      'votingNumbers': instance.votingNumbers,
      'votedAt': instance.votedAt?.toIso8601String(),
      'actualVotedAt': instance.actualVotedAt?.toIso8601String(),
      'createAt': instance.createAt?.toIso8601String(),
      'cadency': instance.cadency,
      'orderPoint': instance.orderPoint,
      'sessionIId': instance.sessionIId,
      'votingIId': instance.votingIId,
      'votingUniqueId': instance.votingUniqueId,
      'topic': instance.topic,
      'votes': instance.votes,
      'votingType': instance.votingType,
      'id': instance.id,
    };

Votes _$VotesFromJson(Map<String, dynamic> json) {
  return Votes(
    json['type'] as int,
    json['cadencyDeputy'] as String,
  );
}

Map<String, dynamic> _$VotesToJson(Votes instance) => <String, dynamic>{
      'type': instance.type,
      'cadencyDeputy': instance.cadencyDeputy,
    };

VotingNumbers _$VotingNumbersFromJson(Map<String, dynamic> json) {
  return VotingNumbers(
    json['inFavor'] as int,
    json['against'] as int,
    json['hold'] as int,
    json['absent'] as int,
  );
}

Map<String, dynamic> _$VotingNumbersToJson(VotingNumbers instance) =>
    <String, dynamic>{
      'inFavor': instance.inFavor,
      'against': instance.against,
      'hold': instance.hold,
      'absent': instance.absent,
    };
