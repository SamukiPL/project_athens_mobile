import 'package:authorization_flow/domain/registration/registration_params.dart';
import 'package:json_annotation/json_annotation.dart';

part 'registration_request.g.dart';

@JsonSerializable()
class RegistrationRequest {

  final String firstName;
  final String lastName;
  final String login;
  final String email;
  final String password;
  final Subscribed subscribed;

  RegistrationRequest({this.firstName, this.lastName, this.login, this.email, this.password, this.subscribed});

  RegistrationRequest.fromParams(RegistrationParams params) :
    firstName = params.firstName,
    lastName = params.lastName,
    login = params.login,
    email = params.email,
    password = params.password,
    subscribed = Subscribed(params.deputies);

  factory RegistrationRequest.fromJson(Map<String, dynamic> json) => _$RegistrationRequestFromJson(json);
  Map<String, dynamic> toJson() => _$RegistrationRequestToJson(this);

}

@JsonSerializable()
class Subscribed {

  final List<String> deputies;

  Subscribed(this.deputies);

  factory Subscribed.fromJson(Map<String, dynamic> json) => _$SubscribedFromJson(json);
  Map<String, dynamic> toJson() => _$SubscribedToJson(this);

}