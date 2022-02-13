import 'package:json_annotation/json_annotation.dart';

part 'login_request.g.dart';

@JsonSerializable()
class LoginRequest {

  final String? login;
  final String? email;
  final String password;
  final int cadence;

  LoginRequest(this.login, this.email, this.password, this.cadence) : assert(
    login != null || email != null
  );

  factory LoginRequest.fromJson(Map<String, dynamic> json) => _$LoginRequestFromJson(json);
  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}