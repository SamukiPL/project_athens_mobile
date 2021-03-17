
import 'package:json_annotation/json_annotation.dart';
import 'package:project_athens/athens_core/data/base_responses/speech_response.dart';

part 'speeches_search_response.g.dart';

@JsonSerializable()
class SpeechesSearchResponse {

  final List<SpeechResponse> speeches;

  SpeechesSearchResponse(this.speeches);

  factory SpeechesSearchResponse.fromJson(Map<String, dynamic> json) => _$SpeechesSearchResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SpeechesSearchResponseToJson(this);

}