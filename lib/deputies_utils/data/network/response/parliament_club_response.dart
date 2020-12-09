import 'package:json_annotation/json_annotation.dart';

part 'parliament_club_response.g.dart';

@JsonSerializable()
class ParliamentClubResponse {
  final List<ParliamentClubBean> parliamentClubs;

  ParliamentClubResponse(this.parliamentClubs);

  factory ParliamentClubResponse.fromJson(Map<String, dynamic> json) => _$ParliamentClubResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ParliamentClubResponseToJson(this);
}

@JsonSerializable()
class ParliamentClubBean {
  final String id;
  final String name;
  final String shortName;
  final String imageSrc;
  final int cadency;
  final DateTime updateAt;
  final DateTime createAt;

  ParliamentClubBean(this.id, this.name, this.shortName, this.imageSrc, this.cadency, this.updateAt, this.createAt);

  factory ParliamentClubBean.fromJson(Map<String, dynamic> json) => _$ParliamentClubBeanFromJson(json);
  Map<String, dynamic> toJson() => _$ParliamentClubBeanToJson(this);

}