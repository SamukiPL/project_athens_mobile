import 'package:json_annotation/json_annotation.dart';
import 'package:project_athens/authorization_flow/domain/registration/check_pair_usage_params.dart';

part 'check_pair_usage_request.g.dart';

@JsonSerializable()
class CheckPairUsageRequest {

  final String username;
  final String email;

  CheckPairUsageRequest(this.username, this.email);

  CheckPairUsageRequest.fromParams(CheckPairUsageParams params) :
      username = params.login,
      email = params.email;

  factory CheckPairUsageRequest.fromJson(Map<String, dynamic> json) => _$CheckPairUsageRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CheckPairUsageRequestToJson(this);

}