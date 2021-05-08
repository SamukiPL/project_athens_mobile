// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deputy_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeputyResponse _$DeputyResponseFromJson(Map<String, dynamic> json) {
  return DeputyResponse(
    json['id'] as String,
    json['cadency'] as int,
    json['name'] as String,
    json['reversedName'] as String,
    json['photoUrl'] as String,
    json['politicalParty'] as String,
    json['parliamentClub'] as String,
    json['cardNumber'] as int,
    json['cardId'] as int,
    json['deputyId'] as String,
    json['isActive'] as bool,
    json['cv'] == null
        ? null
        : CvBean.fromJson(json['cv'] as Map<String, dynamic>),
    json['contact'] == null
        ? null
        : ContactBean.fromJson(json['contact'] as Map<String, dynamic>),
    json['createAt'] as String,
    json['statistics'] == null
        ? null
        : StatisticsBean.fromJson(json['statistics'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$DeputyResponseToJson(DeputyResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cadency': instance.cadency,
      'name': instance.name,
      'reversedName': instance.reversedName,
      'photoUrl': instance.photoUrl,
      'politicalParty': instance.politicalParty,
      'parliamentClub': instance.parliamentClub,
      'cardNumber': instance.cardNumber,
      'cardId': instance.cardId,
      'deputyId': instance.deputyId,
      'isActive': instance.isActive,
      'cv': instance.cv,
      'contact': instance.contact,
      'createAt': instance.createAt,
      'statistics': instance.statistics,
    };

ContactBean _$ContactBeanFromJson(Map<String, dynamic> json) {
  return ContactBean(
    (json['offices'] as List)
        ?.map((e) => e == null
            ? null
            : ContactOfficeBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ContactBeanToJson(ContactBean instance) =>
    <String, dynamic>{
      'offices': instance.offices,
    };

ContactOfficeBean _$ContactOfficeBeanFromJson(Map<String, dynamic> json) {
  return ContactOfficeBean(
    json['name'] as String,
    json['address'] as String,
    json['email'] as String,
    json['isPrimary'] as bool,
    json['telephone'] as String,
  );
}

Map<String, dynamic> _$ContactOfficeBeanToJson(ContactOfficeBean instance) =>
    <String, dynamic>{
      'address': instance.address,
      'name': instance.name,
      'telephone': instance.telephone,
      'email': instance.email,
      'isPrimary': instance.isPrimary,
    };

CvBean _$CvBeanFromJson(Map<String, dynamic> json) {
  return CvBean(
    json['born'] as String,
    json['education'] as String,
    json['finishedSchools'] as String,
    json['profession'] as String,
    json['parliamentExperience'] as String,
  );
}

Map<String, dynamic> _$CvBeanToJson(CvBean instance) => <String, dynamic>{
      'born': instance.born,
      'education': instance.education,
      'finishedSchools': instance.finishedSchools,
      'profession': instance.profession,
      'parliamentExperience': instance.parliamentExperience,
    };

StatisticsBean _$StatisticsBeanFromJson(Map<String, dynamic> json) {
  return StatisticsBean(
    json['createAt'] == null
        ? null
        : DateTime.parse(json['createAt'] as String),
    json['updateAt'] == null
        ? null
        : DateTime.parse(json['updateAt'] as String),
    json['cadency'] as int,
    json['cadencyDeputy'] as String,
    json['speechesCount'] as int,
    json['voteAbsencyCount'] as int,
    (json['clubVoteAccuracy'] as List)
        ?.map((e) => e == null
            ? null
            : ClubVoteAccuracyBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$StatisticsBeanToJson(StatisticsBean instance) =>
    <String, dynamic>{
      'createAt': instance.createAt?.toIso8601String(),
      'updateAt': instance.updateAt?.toIso8601String(),
      'cadency': instance.cadency,
      'cadencyDeputy': instance.cadencyDeputy,
      'speechesCount': instance.speechesCount,
      'voteAbsencyCount': instance.voteAbsencyCount,
      'clubVoteAccuracy': instance.clubVoteAccuracy,
    };

ClubVoteAccuracyBean _$ClubVoteAccuracyBeanFromJson(Map<String, dynamic> json) {
  return ClubVoteAccuracyBean(
    json['compatibleVotes'] as int,
    json['parliamentClub'] as String,
  );
}

Map<String, dynamic> _$ClubVoteAccuracyBeanToJson(
        ClubVoteAccuracyBean instance) =>
    <String, dynamic>{
      'compatibleVotes': instance.compatibleVotes,
      'parliamentClub': instance.parliamentClub,
    };
