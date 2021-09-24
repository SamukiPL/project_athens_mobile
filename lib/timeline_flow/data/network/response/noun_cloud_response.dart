import 'dart:collection';

import 'package:json_annotation/json_annotation.dart';
import 'package:project_athens/athens_core/data/word_model/noun_tag.dart';

part 'noun_cloud_response.g.dart';

@JsonSerializable()
class NounCloudResponse {

  final String id;
  final DateTime? createAt;
  final DateTime? updateAt;
  final int cadency;
  final DateTime? scheduledAt;
  final int sessionIId;
  final List<NounTag> nouns;

  NounCloudResponse(this.id, this.createAt, this.updateAt, this.cadency, this.scheduledAt, this.sessionIId, this.nouns);

  factory NounCloudResponse.fromJson(Map<String, dynamic> json) => _$NounCloudResponseFromJson(json);
  Map<String, dynamic> toJson() => _$NounCloudResponseToJson(this);

}