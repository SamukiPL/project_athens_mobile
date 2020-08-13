// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_pair_usage_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckPairUsageResponse _$CheckPairUsageResponseFromJson(
    Map<String, dynamic> json) {
  return CheckPairUsageResponse(
    json['usernameTaken'] as bool,
    json['emailTaken'] as bool,
  );
}

Map<String, dynamic> _$CheckPairUsageResponseToJson(
        CheckPairUsageResponse instance) =>
    <String, dynamic>{
      'usernameTaken': instance.usernameTaken,
      'emailTaken': instance.emailTaken,
    };
