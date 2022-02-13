// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_remote_configuration_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetRemoteConfigurationResponse _$GetRemoteConfigurationResponseFromJson(
        Map<String, dynamic> json) =>
    GetRemoteConfigurationResponse(
      GetRemoteConfigurationConfig.fromJson(
          json['config'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetRemoteConfigurationResponseToJson(
        GetRemoteConfigurationResponse instance) =>
    <String, dynamic>{
      'config': instance.config,
    };

GetRemoteConfigurationConfig _$GetRemoteConfigurationConfigFromJson(
        Map<String, dynamic> json) =>
    GetRemoteConfigurationConfig(
      json['cadence'] as int,
      RemoteConfigurationAppVersion.fromJson(
          json['minimalAppVersion'] as Map<String, dynamic>),
      RemoteConfigurationAppVersion.fromJson(
          json['recommendedAppVersion'] as Map<String, dynamic>),
      DateTime.parse(json['privacyPolicyVersion'] as String),
    );

Map<String, dynamic> _$GetRemoteConfigurationConfigToJson(
        GetRemoteConfigurationConfig instance) =>
    <String, dynamic>{
      'cadence': instance.cadence,
      'minimalAppVersion': instance.minimalAppVersion,
      'recommendedAppVersion': instance.recommendedAppVersion,
      'privacyPolicyVersion': instance.privacyPolicyVersion.toIso8601String(),
    };

RemoteConfigurationAppVersion _$RemoteConfigurationAppVersionFromJson(
        Map<String, dynamic> json) =>
    RemoteConfigurationAppVersion(
      json['android'] as String,
      json['iOS'] as String,
      json['iPadOS'] as String,
    );

Map<String, dynamic> _$RemoteConfigurationAppVersionToJson(
        RemoteConfigurationAppVersion instance) =>
    <String, dynamic>{
      'android': instance.android,
      'iOS': instance.iOS,
      'iPadOS': instance.iPadOS,
    };
