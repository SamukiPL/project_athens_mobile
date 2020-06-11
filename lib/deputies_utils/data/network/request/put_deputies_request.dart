import 'package:json_annotation/json_annotation.dart';

part 'put_deputies_request.g.dart';

@JsonSerializable()
class PutDeputiesRequest {

  final List<Deputy> deputies;

  PutDeputiesRequest(this.deputies);

  factory PutDeputiesRequest.fromJson(Map<String, dynamic> json) => _$PutDeputiesRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PutDeputiesRequestToJson(this);

}

@JsonSerializable()
class Deputy {

  final String deputyId;
  final Notifications notifications;

  Deputy(this.deputyId, this.notifications);

  factory Deputy.fromJson(Map<String, dynamic> json) => _$DeputyFromJson(json);
  Map<String, dynamic> toJson() => _$DeputyToJson(this);

}

@JsonSerializable()
class Notifications {

  final bool vote;
  final bool speech;
  final bool interpolation;

  Notifications(this.vote, this.speech, this.interpolation);

  factory Notifications.fromJson(Map<String, dynamic> json) => _$NotificationsFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationsToJson(this);

}