import 'package:json_annotation/json_annotation.dart';

part 'deputy_response.g.dart';

@JsonSerializable()
class DeputyResponse {
  final String id;
  final int cadency;
  final String name;
  final String reversedName;
  final String photoUrl;
  final String politicalParty;
  final String parliamentClub;
  final int cardNumber;
  final String deputyId;
  final bool isActive;
  final CvBean cv;
  final ContactBean contact;
  final String createAt;

  DeputyResponse(this.id, this.cadency, this.name, this.reversedName, this.photoUrl, this.politicalParty, this.parliamentClub, this.cardNumber, this.deputyId, this.isActive, this.cv, this.contact, this.createAt);

  factory DeputyResponse.fromJson(Map<String, dynamic> json) => _$DeputyResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DeputyResponseToJson(this);

}

@JsonSerializable()
class ContactBean {
  final List<String> offices;

  ContactBean(this.offices);

  factory ContactBean.fromJson(Map<String, dynamic> json) => _$ContactBeanFromJson(json);
  Map<String, dynamic> toJson() => _$ContactBeanToJson(this);

}

@JsonSerializable()
class CvBean {
  final String born;
  final String education;
  final String finishedSchools;
  final String profession;

  CvBean(this.born, this.education, this.finishedSchools, this.profession);

  factory CvBean.fromJson(Map<String, dynamic> json) => _$CvBeanFromJson(json);
  Map<String, dynamic> toJson() => _$CvBeanToJson(this);

}