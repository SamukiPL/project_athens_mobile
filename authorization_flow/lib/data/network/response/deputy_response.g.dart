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
    json['politicalParty'] as String,
    json['parliamentClub'] as String,
    json['cardNumber'] as int,
    json['deputyId'] as String,
    json['isActive'] as bool,
    json['cv'] == null
        ? null
        : CvBean.fromJson(json['cv'] as Map<String, dynamic>),
    json['contact'] == null
        ? null
        : ContactBean.fromJson(json['contact'] as Map<String, dynamic>),
    json['createAt'] as String,
  );
}

Map<String, dynamic> _$DeputyResponseToJson(DeputyResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cadency': instance.cadency,
      'name': instance.name,
      'reversedName': instance.reversedName,
      'politicalParty': instance.politicalParty,
      'parliamentClub': instance.parliamentClub,
      'cardNumber': instance.cardNumber,
      'deputyId': instance.deputyId,
      'isActive': instance.isActive,
      'cv': instance.cv,
      'contact': instance.contact,
      'createAt': instance.createAt,
    };

ContactBean _$ContactBeanFromJson(Map<String, dynamic> json) {
  return ContactBean(
    (json['offices'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$ContactBeanToJson(ContactBean instance) =>
    <String, dynamic>{
      'offices': instance.offices,
    };

CvBean _$CvBeanFromJson(Map<String, dynamic> json) {
  return CvBean(
    json['born'] as String,
    json['education'] as String,
    json['finishedSchools'] as String,
    json['profession'] as String,
  );
}

Map<String, dynamic> _$CvBeanToJson(CvBean instance) => <String, dynamic>{
      'born': instance.born,
      'education': instance.education,
      'finishedSchools': instance.finishedSchools,
      'profession': instance.profession,
    };
