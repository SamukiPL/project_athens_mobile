import 'package:json_annotation/json_annotation.dart';

part 'deputy_request.g.dart';

@JsonSerializable()
class DeputyRequest {

  final List<Deputy> deputies;

  DeputyRequest(this.deputies);

  factory DeputyRequest.fromJson(Map<String, dynamic> json) => _$DeputyRequestFromJson(json);
  Map<String, dynamic> toJson() => _$DeputyRequestToJson(this);

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

  Notifications({this.vote = true, this.speech = true, this.interpolation = true});

  factory Notifications.fromJson(Map<String, dynamic> json) => _$NotificationsFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationsToJson(this);

}