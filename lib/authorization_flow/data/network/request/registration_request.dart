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
  final int cadence;

  RegistrationRequest(
      {required this.firstName,
      required this.lastName,
      required this.login,
      required this.email,
      required this.password,
      required this.cadence
    });

  RegistrationRequest.fromParams(RegistrationParams params)
      : firstName = params.firstName,
        lastName = params.lastName,
        login = params.login,
        email = params.email,
        password = params.password,
        cadence = params.cadence;

  factory RegistrationRequest.fromJson(Map<String, dynamic> json) =>
      _$RegistrationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegistrationRequestToJson(this);
}
