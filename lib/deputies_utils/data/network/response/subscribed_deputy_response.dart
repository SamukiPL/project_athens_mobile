import 'package:json_annotation/json_annotation.dart';
import 'package:project_athens/athens_core/utils/firebase/firebase_deputy_subscriber.dart';

part 'subscribed_deputy_response.g.dart';

@JsonSerializable()
class SubscribedDeputyResponse {

  final String id;
  final DateTime createAt;
  final int cadency;
  final bool isPrimary;
  final String cadencyDeputyId;
  final Notifications notifications;

  SubscribedDeputyResponse(this.id, this.createAt, this.cadency, this.isPrimary, this.cadencyDeputyId, this.notifications);

	factory SubscribedDeputyResponse.fromJson(Map<String, dynamic> json) => _$SubscribedDeputyResponseFromJson(json);
	Map<String, dynamic> toJson() => _$SubscribedDeputyResponseToJson(this);
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

extension SubscribedDeputyResponseExt on SubscribedDeputyResponse {
	FirebaseDeputySubscribeModel toFirebaseDeputySubscribeModel() =>
			FirebaseDeputySubscribeModel(cadencyDeputyId, notifications.vote, notifications.speech, notifications.interpolation);
}

