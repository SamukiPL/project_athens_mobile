import 'package:json_annotation/json_annotation.dart';

part 'speech_search_request.g.dart';

@JsonSerializable()
class SpeechSearchRequest {

  final int limit;
  final int offset;
  final String searchPhrase;
  final String? from;
  final String? to;
  final String sort;
  final int cadency;

  SpeechSearchRequest(this.limit, this.offset, this.searchPhrase, this.from, this.to, this.sort, this.cadency);

  factory SpeechSearchRequest.fromJson(Map<String, dynamic> json) => _$SpeechSearchRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SpeechSearchRequestToJson(this);

}