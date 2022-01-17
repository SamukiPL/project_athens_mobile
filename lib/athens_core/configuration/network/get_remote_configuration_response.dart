import 'package:json_annotation/json_annotation.dart';

part 'get_remote_configuration_response.g.dart';

@JsonSerializable()
class GetRemoteConfigurationResponse {
  final GetRemoteConfigurationConfig config;

  GetRemoteConfigurationResponse(this.config);

  factory GetRemoteConfigurationResponse.fromJson(Map<String, dynamic> json) => _$GetRemoteConfigurationResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetRemoteConfigurationResponseToJson(this);
}

@JsonSerializable()
class GetRemoteConfigurationConfig {

  final int cadence;
  final RemoteConfigurationMinimalAppVersion minimalAppVersion;

  GetRemoteConfigurationConfig(this.cadence, this.minimalAppVersion);


  factory GetRemoteConfigurationConfig.fromJson(Map<String, dynamic> json) => _$GetRemoteConfigurationConfigFromJson(json);
  Map<String, dynamic> toJson() => _$GetRemoteConfigurationConfigToJson(this);
}

@JsonSerializable()
class RemoteConfigurationMinimalAppVersion {
  final String android;
  final String iOS;
  final String iPadOS;

  RemoteConfigurationMinimalAppVersion(this.android, this.iOS, this.iPadOS);

  factory RemoteConfigurationMinimalAppVersion.fromJson(Map<String, dynamic> json) => _$RemoteConfigurationMinimalAppVersionFromJson(json);
  Map<String, dynamic> toJson() => _$RemoteConfigurationMinimalAppVersionToJson(this);
}
