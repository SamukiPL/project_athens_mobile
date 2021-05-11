import 'package:json_annotation/json_annotation.dart';
import 'package:project_athens/athens_core/data/word_model/noun_tag.dart';

part 'deputy_nouns_response.g.dart';


@JsonSerializable()
class DeputyNounsResponse {
  final List<NounTag> nouns;

  DeputyNounsResponse(this.nouns);

  factory DeputyNounsResponse.fromJson(Map<String, dynamic> json) => _$DeputyNounsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DeputyNounsResponseToJson(this);
}