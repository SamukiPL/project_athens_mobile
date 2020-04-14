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
    subscribed: json['subscribed'] == null
        ? null
        : Subscribed.fromJson(json['subscribed'] as Map<String, dynamic>),
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
      'subscribed': instance.subscribed,
    };

Subscribed _$SubscribedFromJson(Map<String, dynamic> json) {
  return Subscribed(
    (json['deputies'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$SubscribedToJson(Subscribed instance) =>
    <String, dynamic>{
      'deputies': instance.deputies,
    };
