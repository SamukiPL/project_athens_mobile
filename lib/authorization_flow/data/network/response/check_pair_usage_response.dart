import 'package:json_annotation/json_annotation.dart';

part 'check_pair_usage_response.g.dart';

@JsonSerializable()
class CheckPairUsageResponse {

  final bool usernameTaken;
  final bool emailTaken;

  CheckPairUsageResponse(this.usernameTaken, this.emailTaken);

  factory CheckPairUsageResponse.fromJson(Map<String, dynamic> json) => _$CheckPairUsageResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CheckPairUsageResponseToJson(this);

}