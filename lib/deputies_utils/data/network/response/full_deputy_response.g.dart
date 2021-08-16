// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'full_deputy_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FullDeputyResponse _$FullDeputyResponseFromJson(Map<String, dynamic> json) {
  return FullDeputyResponse(
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
    CvBean.fromJson(json['cv'] as Map<String, dynamic>),
    ContactBean.fromJson(json['contact'] as Map<String, dynamic>),
    StatisticsBean.fromJson(json['statistics'] as Map<String, dynamic>),
    DateTime.parse(json['createAt'] as String),
    DateTime.parse(json['updateAt'] as String),
  );
}

Map<String, dynamic> _$FullDeputyResponseToJson(FullDeputyResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cadency': instance.cadency,
      'isActive': instance.isActive,
      'name': instance.name,
      'parliamentClub': instance.parliamentClub,
      'photoUrl': instance.photoUrl,
      'cardNumber': instance.cardNumber,
      'reversedName': instance.reversedName,
      'politicalParty': instance.politicalParty,
      'cardId': instance.cardId,
      'deputyId': instance.deputyId,
      'cv': instance.cv,
      'contact': instance.contact,
      'statistics': instance.statistics,
      'createAt': instance.createAt.toIso8601String(),
      'updateAt': instance.updateAt.toIso8601String(),
    };

ContactBean _$ContactBeanFromJson(Map<String, dynamic> json) {
  return ContactBean(
    (json['offices'] as List<dynamic>)
        .map((e) => ContactOfficeBean.fromJson(e as Map<String, dynamic>))
        .toList(),
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
    DateTime.parse(json['createAt'] as String),
    DateTime.parse(json['updateAt'] as String),
    json['cadency'] as int,
    json['cadencyDeputy'] as String,
    json['speechesCount'] as int,
    json['voteAbsencyCount'] as int,
    (json['clubVoteAccuracy'] as List<dynamic>)
        .map((e) => ClubVoteAccuracyBean.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$StatisticsBeanToJson(StatisticsBean instance) =>
    <String, dynamic>{
      'createAt': instance.createAt.toIso8601String(),
      'updateAt': instance.updateAt.toIso8601String(),
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
