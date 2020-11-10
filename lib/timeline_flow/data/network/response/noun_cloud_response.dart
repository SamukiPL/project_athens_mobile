import 'dart:collection';

import 'package:json_annotation/json_annotation.dart';

part 'noun_cloud_response.g.dart';

@JsonSerializable()
class NounCloudResponse {

  final String id;
  final DateTime createAt;
  final DateTime updateAt;
  final int cadency;
  final DateTime scheduledAt;
  final int sessionIId;
  final LinkedHashMap<String, int> nouns;

  NounCloudResponse(this.id, this.createAt, this.updateAt, this.cadency, this.scheduledAt, this.sessionIId, this.nouns);

  factory NounCloudResponse.fromJson(Map<String, dynamic> json) => _$NounCloudResponseFromJson(json);
  Map<String, dynamic> toJson() => _$NounCloudResponseToJson(this);

}