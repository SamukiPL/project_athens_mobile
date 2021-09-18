import 'package:json_annotation/json_annotation.dart';

part 'full_deputy_response.g.dart';

@JsonSerializable()
class FullDeputyResponse {
  final String id;
  final int cadency;
  final bool isActive;
  final String name;
  final String parliamentClub;
  final String photoUrl;
  final int cardNumber;
  final String reversedName;
  final String politicalParty;
  final int cardId;
  final String deputyId;
  final CvBean cv;
  final ContactBean contact;
  final StatisticsBean statistics;
  final DateTime createAt;
  final DateTime updateAt;

  FullDeputyResponse(this.id, this.cadency, this.name, this.reversedName, this.photoUrl, this.politicalParty, this.parliamentClub, this.cardNumber, this.cardId, this.deputyId, this.isActive, this.cv, this.contact, this.statistics, this.createAt, this.updateAt);

  factory FullDeputyResponse.fromJson(Map<String, dynamic> json) => _$FullDeputyResponseFromJson(json);
  Map<String, dynamic> toJson() => _$FullDeputyResponseToJson(this);
}

@JsonSerializable()
class ContactBean {
  final List<ContactOfficeBean> offices;

  ContactBean(this.offices);

  factory ContactBean.fromJson(Map<String, dynamic> json) => _$ContactBeanFromJson(json);
  Map<String, dynamic> toJson() => _$ContactBeanToJson(this);
}

@JsonSerializable()
class ContactOfficeBean {
  final String address;
  final String name;
  final String telephone;
  final String email;
  final bool isPrimary;

  ContactOfficeBean(this.name, this.address, this.email, this.isPrimary, this.telephone);

  factory ContactOfficeBean.fromJson(Map<String, dynamic> json) => _$ContactOfficeBeanFromJson(json);
  Map<String, dynamic> toJson() => _$ContactOfficeBeanToJson(this);
}

@JsonSerializable()
class CvBean {
  final String born;
  final String education;
  final String finishedSchools;
  final String profession;
  final String parliamentExperience;

  CvBean(this.born, this.education, this.finishedSchools, this.profession, this.parliamentExperience);

  factory CvBean.fromJson(Map<String, dynamic> json) => _$CvBeanFromJson(json);
  Map<String, dynamic> toJson() => _$CvBeanToJson(this);

}

@JsonSerializable()
class StatisticsBean {
  final DateTime createAt;
  final DateTime updateAt;
  final int cadency;
  final String cadencyDeputy;
  final int speechesCount;
  final int voteAbsencyCount;
  final List<ClubVoteAccuracyBean> clubVoteAccuracy;

  StatisticsBean(this.createAt, this.updateAt, this.cadency, this.cadencyDeputy, this.speechesCount, this.voteAbsencyCount, this.clubVoteAccuracy);

  factory StatisticsBean.fromJson(Map<String, dynamic> json) => _$StatisticsBeanFromJson(json);
  Map<String, dynamic> toJSON() => _$StatisticsBeanToJson(this);
}

@JsonSerializable()
class ClubVoteAccuracyBean {
  final int compatibleVotes;
  final String parliamentClub;

  ClubVoteAccuracyBean(this.compatibleVotes, this.parliamentClub);

  factory ClubVoteAccuracyBean.fromJson(Map<String, dynamic> json) => _$ClubVoteAccuracyBeanFromJson(json);
  Map<String, dynamic> toJSON() => _$ClubVoteAccuracyBeanToJson(this);
}