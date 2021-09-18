import 'package:json_annotation/json_annotation.dart';

part 'deputy_response.g.dart';

@JsonSerializable()
class DeputyResponse {
  final String id;
  final int cadency;
  final bool isActive;
  final String name;
  final String parliamentClub;
  final String photoUrl;
  final int cardId;

  DeputyResponse(this.id, this.cadency, this.name, this.photoUrl, this.parliamentClub, this.cardId, this.isActive);

  factory DeputyResponse.fromJson(Map<String, dynamic> json) => _$DeputyResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DeputyResponseToJson(this);
}