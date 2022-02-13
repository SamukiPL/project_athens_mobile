// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_pair_usage_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckPairUsageRequest _$CheckPairUsageRequestFromJson(
        Map<String, dynamic> json) =>
    CheckPairUsageRequest(
      json['username'] as String,
      json['email'] as String,
    );

Map<String, dynamic> _$CheckPairUsageRequestToJson(
        CheckPairUsageRequest instance) =>
    <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
    };
