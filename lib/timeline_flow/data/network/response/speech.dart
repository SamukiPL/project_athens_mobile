import 'package:project_athens/athens_core/models/gender.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:project_athens/timeline_flow/data/network/response/timeline_response.dart';

part 'speech.g.dart';

@JsonSerializable()
class Speech extends TimelineItem {

  final Agenda agenda;
  final CisInfo cisInfo;
  final DateTime createAt;
  final String id;
  final int deputyCardIdentifier;
  final String fileName;
  final String videoDownloadUrl;
  final int length;
  final String personName;
  final String cadencyDeputy;
  final String parliamentClub;
  final int cadency;
  final String rangeId;

  Speech(this.agenda, this.cisInfo, this.createAt, this.id, this.deputyCardIdentifier, this.fileName, this.videoDownloadUrl, this.length, this.personName, this.cadencyDeputy, this.parliamentClub, this.cadency, this.rangeId);

  factory Speech.fromJson(Map<String, dynamic> json) => _$SpeechFromJson(json);
  Map<String, dynamic> toJson() => _$SpeechToJson(this);
}

@JsonSerializable()
class Agenda {
  final DateTime eventDateTime;
  final DateTime msgDateTime;
  final String refId;
  final String rangeid;
  final String title;

  Agenda(this.eventDateTime, this.msgDateTime, this.refId, this.rangeid, this.title);

  factory Agenda.fromJson(Map<String, dynamic> json) => _$AgendaFromJson(json);
  Map<String, dynamic> toJson() => _$AgendaToJson(this);
}

@JsonSerializable()
class CisInfo {
  final Person person;
  final DateTime eventDateTime;
  final DateTime msgDateTime;
  final String rangeid;
  final String refId;

  CisInfo(this.person, this.eventDateTime, this.msgDateTime, this.rangeid, this.refId);

  factory CisInfo.fromJson(Map<String, dynamic> json) => _$CisInfoFromJson(json);
  Map<String, dynamic> toJson() => _$CisInfoToJson(this);
}

@JsonSerializable()
class Person {

  final String name;
  final String surname;
  final Gender gender;
  final String function;
  final String other;
  final int deputyCardNumber;
  final int termOfficeNumber;

  Person(this.name, this.surname, this.gender, this.function, this.other, this.deputyCardNumber, this.termOfficeNumber);

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
  Map<String, dynamic> toJson() => _$PersonToJson(this);
}