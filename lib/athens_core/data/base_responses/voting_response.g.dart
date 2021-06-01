// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voting_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VotingResponse _$VotingResponseFromJson(Map<String, dynamic> json) {
  return VotingResponse(
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
    json['orderPoint'] as int,
    json['sessionIId'] as int,
    json['votingIId'] as int,
    json['votingUniqueId'] as String,
    json['topic'] as String,
    (json['votes'] as List)
        ?.map(
            (e) => e == null ? null : Votes.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    _$enumDecodeNullable(_$VotingTypeEnumMap, json['votingType']),
    json['id'] as String,
    json['absoluteMajority'] as int,
    json['qualifyingMajority'] as int,
    (json['parliamentClubVotingNumbers'] as List)
        ?.map((e) => e == null
            ? null
            : ParliamentClubVotingNumbers.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['deputyVoteType'] as int,
    json['updateAt'] == null
        ? null
        : DateTime.parse(json['updateAt'] as String),
  );
}

Map<String, dynamic> _$VotingResponseToJson(VotingResponse instance) =>
    <String, dynamic>{
      'votingNumbers': instance.votingNumbers,
      'votedAt': instance.votedAt?.toIso8601String(),
      'actualVotedAt': instance.actualVotedAt?.toIso8601String(),
      'createAt': instance.createAt?.toIso8601String(),
      'updateAt': instance.updateAt?.toIso8601String(),
      'cadency': instance.cadency,
      'orderPoint': instance.orderPoint,
      'sessionIId': instance.sessionIId,
      'votingIId': instance.votingIId,
      'votingUniqueId': instance.votingUniqueId,
      'topic': instance.topic,
      'votes': instance.votes,
      'votingType': _$VotingTypeEnumMap[instance.votingType],
      'id': instance.id,
      'absoluteMajority': instance.absoluteMajority,
      'qualifyingMajority': instance.qualifyingMajority,
      'parliamentClubVotingNumbers': instance.parliamentClubVotingNumbers,
      'deputyVoteType': instance.deputyVoteType,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$VotingTypeEnumMap = {
  VotingType.RESOLUTION_PROJECT: 0,
  VotingType.LAW_PROJECT: 1,
  VotingType.BREAK: 2,
  VotingType.QUORUM: 3,
  VotingType.REPORT: 4,
  VotingType.VOTE_OF_NO_CONFIDENCE: 5,
  VotingType.COMPLETION_OF_AGENDA: 6,
  VotingType.SHORTENING_DEADLINE: 7,
  VotingType.CHANGE_COMISSION_MEMBERS: 8,
  VotingType.VOTE_FOR_PROPOSAL: 9,
  VotingType.PERSON_VOTE: 10,
  VotingType.VOTE_FOR_POSTPONEMENT_GATHERING: 11,
  VotingType.MARSHAL: 12,
  VotingType.VICE_MARSHAL: 13,
  VotingType.CHOOSE_COMISSION_MEMBERS: 14,
  VotingType.SELECTION_OF_PARLIAMENT_SECRETARIES: 15,
  VotingType.VOTE_OF_CONFIDENCE: 16,
  VotingType.SELECTION_OF_STATE_TRIBUNAL: 17,
  VotingType.SELECTION_OF_CONSTITUTIONAL_COURT: 18,
  VotingType.SELECTION_OF_DEPUTY_MEMBER_NATIONAL_COUNCIL_JUDICIARY: 19,
  VotingType.UNKNOWN: 999,
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

ParliamentClubVotingNumbers _$ParliamentClubVotingNumbersFromJson(
    Map<String, dynamic> json) {
  return ParliamentClubVotingNumbers(
    json['inFavor'] as int,
    json['against'] as int,
    json['hold'] as int,
    json['absent'] as int,
    json['totalDeputies'] as int,
    json['actualVoted'] as int,
    json['parliamentClub'] as String,
  );
}

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
