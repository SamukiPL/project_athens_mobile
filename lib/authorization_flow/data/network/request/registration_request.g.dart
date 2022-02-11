// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registration_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegistrationRequest _$RegistrationRequestFromJson(Map<String, dynamic> json) {
  return RegistrationRequest(
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    login: json['login'] as String,
    email: json['email'] as String,
    password: json['password'] as String,
    cadence: json['cadence'] as int,
  );
}

Map<String, dynamic> _$RegistrationRequestToJson(
        RegistrationRequest instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'login': instance.login,
      'email': instance.email,
      'password': instance.password,
      'cadence': instance.cadence,
    };
