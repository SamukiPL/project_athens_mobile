// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_account_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteAccountRequest _$DeleteAccountRequestFromJson(
        Map<String, dynamic> json) =>
    DeleteAccountRequest(
      json['reason'] as String,
      json['additionalNotes'] as String?,
      json['deviceInfo'] as String?,
    );

Map<String, dynamic> _$DeleteAccountRequestToJson(
        DeleteAccountRequest instance) =>
    <String, dynamic>{
      'reason': instance.reason,
      'additionalNotes': instance.additionalNotes,
      'deviceInfo': instance.deviceInfo,
    };
