import 'package:json_annotation/json_annotation.dart';

part 'noun_tag.g.dart';

@JsonSerializable()
class NounTag {
  final String key;
  final int hits;

  NounTag(this.key, this.hits);

  factory NounTag.fromJson(Map<String, dynamic> json) => _$NounTagFromJson(json);
  Map<String, dynamic> toJson() => _$NounTagToJson(this);
}