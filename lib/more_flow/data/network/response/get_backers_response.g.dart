// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_backers_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBackersResponse _$GetBackersResponseFromJson(Map<String, dynamic> json) =>
    GetBackersResponse(
      (json['backers'] as List<dynamic>)
          .map((e) => Backer.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetBackersResponseToJson(GetBackersResponse instance) =>
    <String, dynamic>{
      'backers': instance.backers,
    };

Backer _$BackerFromJson(Map<String, dynamic> json) => Backer(
      json['nickname'] as String,
      json['amount'] as int,
      json['hasBadge'] as bool?,
      json['comment'] as String?,
      DateTime.parse(json['backedAt'] as String),
      json['isCurrentUser'] as bool?,
    );

Map<String, dynamic> _$BackerToJson(Backer instance) => <String, dynamic>{
      'nickname': instance.nickname,
      'amount': instance.amount,
      'hasBadge': instance.hasBadge,
      'comment': instance.comment,
      'backedAt': instance.backedAt.toIso8601String(),
      'isCurrentUser': instance.isCurrentUser,
    };
