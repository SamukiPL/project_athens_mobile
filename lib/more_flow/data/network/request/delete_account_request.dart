import 'package:json_annotation/json_annotation.dart';

part 'delete_account_request.g.dart';

@JsonSerializable()
class DeleteAccountRequest {
  final String reason;
  final String? additionalNotes;
  final String? deviceInfo;

  DeleteAccountRequest(this.reason, this.additionalNotes, this.deviceInfo);

  factory DeleteAccountRequest.fromJson(Map<String, dynamic> json) => _$DeleteAccountRequestFromJson(json);
  Map<String, dynamic> toJson() => _$DeleteAccountRequestToJson(this);
}