// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_remote_configuration_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetRemoteConfigurationResponse _$GetRemoteConfigurationResponseFromJson(
    Map<String, dynamic> json) {
  return GetRemoteConfigurationResponse(
    GetRemoteConfigurationConfig.fromJson(
        json['config'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GetRemoteConfigurationResponseToJson(
        GetRemoteConfigurationResponse instance) =>
    <String, dynamic>{
      'config': instance.config,
    };

GetRemoteConfigurationConfig _$GetRemoteConfigurationConfigFromJson(
    Map<String, dynamic> json) {
  return GetRemoteConfigurationConfig(
    json['cadence'] as int,
    RemoteConfigurationMinimalAppVersion.fromJson(
        json['minimalAppVersion'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GetRemoteConfigurationConfigToJson(
        GetRemoteConfigurationConfig instance) =>
    <String, dynamic>{
      'cadence': instance.cadence,
      'minimalAppVersion': instance.minimalAppVersion,
    };

RemoteConfigurationMinimalAppVersion
    _$RemoteConfigurationMinimalAppVersionFromJson(Map<String, dynamic> json) {
  return RemoteConfigurationMinimalAppVersion(
    json['android'] as String,
    json['iOS'] as String,
    json['iPadOS'] as String,
  );
}

Map<String, dynamic> _$RemoteConfigurationMinimalAppVersionToJson(
        RemoteConfigurationMinimalAppVersion instance) =>
    <String, dynamic>{
      'android': instance.android,
      'iOS': instance.iOS,
      'iPadOS': instance.iPadOS,
    };
