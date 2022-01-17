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
  final RemoteConfigurationAppVersion minimalAppVersion;
  final RemoteConfigurationAppVersion recommendedAppVersion;

  GetRemoteConfigurationConfig(this.cadence, this.minimalAppVersion, this.recommendedAppVersion);


  factory GetRemoteConfigurationConfig.fromJson(Map<String, dynamic> json) => _$GetRemoteConfigurationConfigFromJson(json);
  Map<String, dynamic> toJson() => _$GetRemoteConfigurationConfigToJson(this);
}

@JsonSerializable()
class RemoteConfigurationAppVersion {
  final String android;
  final String iOS;
  final String iPadOS;

  RemoteConfigurationAppVersion(this.android, this.iOS, this.iPadOS);

  factory RemoteConfigurationAppVersion.fromJson(Map<String, dynamic> json) => _$RemoteConfigurationAppVersionFromJson(json);
  Map<String, dynamic> toJson() => _$RemoteConfigurationAppVersionToJson(this);
}
