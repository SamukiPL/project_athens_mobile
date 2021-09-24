import 'package:json_annotation/json_annotation.dart';

part 'vote_search_request.g.dart';

@JsonSerializable()
class VoteSearchRequest {

  final int limit;
  final int offset;
  final String searchPhrase;
  final String? from;
  final String? to;
  final String sort;
  final int cadency;
  final bool v2;

  VoteSearchRequest(this.limit, this.offset, this.searchPhrase, this.from, this.to, this.sort, this.cadency, {this.v2 = false});

  factory VoteSearchRequest.fromJson(Map<String, dynamic> json) => _$VoteSearchRequestFromJson(json);
  Map<String, dynamic> toJson() => _$VoteSearchRequestToJson(this);

}