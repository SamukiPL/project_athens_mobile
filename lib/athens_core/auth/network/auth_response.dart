import 'package:json_annotation/json_annotation.dart';

part 'auth_response.g.dart';

@JsonSerializable(nullable: true)
class AuthResponse {

  final String accessToken;
  final String refreshToken;

  AuthResponse(this.accessToken, this.refreshToken);

  factory AuthResponse.fromJson(Map<String, dynamic> json) => _$AuthResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);

}