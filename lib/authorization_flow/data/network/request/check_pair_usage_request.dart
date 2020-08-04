import 'package:json_annotation/json_annotation.dart';

part 'check_pair_usage_request.g.dart';

@JsonSerializable()
class CheckPairUsageRequest {

  final String username;
  final String email;

  CheckPairUsageRequest(this.username, this.email);

  factory CheckPairUsageRequest.fromJson(Map<String, dynamic> json) => _$CheckPairUsageRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CheckPairUsageRequestToJson(this);

}