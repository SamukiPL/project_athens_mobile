import 'package:project_athens/authorization_flow/domain/registration/registration_params.dart';
import 'package:json_annotation/json_annotation.dart';

part 'registration_request.g.dart';

@JsonSerializable()
class RegistrationRequest {

  final String firstName;
  final String lastName;
  final String login;
  final String email;
  final String password;

  RegistrationRequest({this.firstName, this.lastName, this.login, this.email, this.password});

  RegistrationRequest.fromParams(RegistrationParams params) :
    firstName = params.firstName,
    lastName = params.lastName,
    login = params.login,
    email = params.email,
    password = params.password;

  factory RegistrationRequest.fromJson(Map<String, dynamic> json) => _$RegistrationRequestFromJson(json);
  Map<String, dynamic> toJson() => _$RegistrationRequestToJson(this);

}