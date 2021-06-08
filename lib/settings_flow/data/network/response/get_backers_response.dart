import 'package:json_annotation/json_annotation.dart';

part 'get_backers_response.g.dart';

@JsonSerializable()
class GetBackersResponse {
  final List<Backer> backers;

  GetBackersResponse(this.backers);

  factory GetBackersResponse.fromJson(Map<String, dynamic> json) => _$GetBackersResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetBackersResponseToJson(this);
}

@JsonSerializable()
class Backer {
  final String nickname;
  final int amount;
  final bool hasBadge;
  final String comment;
  final DateTime backedAt;
  final bool isCurrentUser;

  Backer(this.nickname, this.amount, this.hasBadge, this.comment, this.backedAt, this.isCurrentUser);

  factory Backer.fromJson(Map<String, dynamic> json) => _$BackerFromJson(json);
  Map<String, dynamic> toJson() => _$BackerToJson(this);
}
