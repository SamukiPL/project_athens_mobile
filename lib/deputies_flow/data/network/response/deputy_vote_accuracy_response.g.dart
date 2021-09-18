// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deputy_vote_accuracy_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeputyVoteAccuracyResponse _$DeputyVoteAccuracyResponseFromJson(
    Map<String, dynamic> json) {
  return DeputyVoteAccuracyResponse(
    (json['votes'] as List<dynamic>)
        .map((e) => VoteSlimDTO.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$DeputyVoteAccuracyResponseToJson(
        DeputyVoteAccuracyResponse instance) =>
    <String, dynamic>{
      'votes': instance.votes,
    };

VoteSlimDTO _$VoteSlimDTOFromJson(Map<String, dynamic> json) {
  return VoteSlimDTO(
    json['id'] as String,
    json['agenda'] as String,
    _$enumDecode(_$VotingTypeEnumMap, json['type']),
    DateTime.parse(json['voteAt'] as String),
    VoteSlimVotingNumbersDTO.fromJson(
        json['voteNumbers'] as Map<String, dynamic>),
    (json['clubsMajority'] as List<dynamic>)
        .map((e) => VoteSlimClubMajorityDTO.fromJson(e as Map<String, dynamic>))
        .toList(),
    (json['deputiesVoteType'] as List<dynamic>)
        .map((e) =>
            VoteSlimDeputyMajorityVoteDTO.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['qualifyingMajority'] as int,
    json['absoluteMajority'] as int,
    json['orderPoint'] as int,
  );
}

Map<String, dynamic> _$VoteSlimDTOToJson(VoteSlimDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'agenda': instance.agenda,
      'type': _$VotingTypeEnumMap[instance.type],
      'voteAt': instance.voteAt.toIso8601String(),
      'voteNumbers': instance.voteNumbers,
      'qualifyingMajority': instance.qualifyingMajority,
      'absoluteMajority': instance.absoluteMajority,
      'clubsMajority': instance.clubsMajority,
      'deputiesVoteType': instance.deputiesVoteType,
      'orderPoint': instance.orderPoint,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
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
  VotingType.REPEAL_OF_REGULATION: 20,
  VotingType.RESOLUTION_OF_POINT_OF_DISPUTE: 21,
  VotingType.REQUEST_OF_REASSUMING_VOTE: 22,
  VotingType.REQUEST_OF_CLOSING_MEETING: 23,
  VotingType.UNKNOWN: 999,
};

VoteSlimClubMajorityDTO _$VoteSlimClubMajorityDTOFromJson(
    Map<String, dynamic> json) {
  return VoteSlimClubMajorityDTO(
    json['parliamentClub'] as String,
    _$enumDecode(_$VoteTypeEnumMap, json['voteMajority']),
  );
}

Map<String, dynamic> _$VoteSlimClubMajorityDTOToJson(
        VoteSlimClubMajorityDTO instance) =>
    <String, dynamic>{
      'parliamentClub': instance.parliamentClub,
      'voteMajority': _$VoteTypeEnumMap[instance.voteMajority],
    };

const _$VoteTypeEnumMap = {
  VoteType.IN_FAVOR: 0,
  VoteType.AGAINST: 1,
  VoteType.HOLD: 2,
  VoteType.ABSENT: 3,
};

VoteSlimDeputyMajorityVoteDTO _$VoteSlimDeputyMajorityVoteDTOFromJson(
    Map<String, dynamic> json) {
  return VoteSlimDeputyMajorityVoteDTO(
    json['cadencyDeputy'] as String,
    _$enumDecode(_$VoteTypeEnumMap, json['voteType']),
  );
}

Map<String, dynamic> _$VoteSlimDeputyMajorityVoteDTOToJson(
        VoteSlimDeputyMajorityVoteDTO instance) =>
    <String, dynamic>{
      'cadencyDeputy': instance.cadencyDeputy,
      'voteType': _$VoteTypeEnumMap[instance.voteType],
    };

VoteSlimVotingNumbersDTO _$VoteSlimVotingNumbersDTOFromJson(
    Map<String, dynamic> json) {
  return VoteSlimVotingNumbersDTO(
    json['inFavor'] as int,
    json['against'] as int,
    json['hold'] as int,
    json['absent'] as int,
  );
}

Map<String, dynamic> _$VoteSlimVotingNumbersDTOToJson(
        VoteSlimVotingNumbersDTO instance) =>
    <String, dynamic>{
      'inFavor': instance.inFavor,
      'against': instance.against,
      'hold': instance.hold,
      'absent': instance.absent,
    };
