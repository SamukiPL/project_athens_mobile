import 'package:json_annotation/json_annotation.dart';

part 'saved_notification.g.dart';

@JsonSerializable()
class SavedNotification {
  final String title;
  final String? body;
  final String? imgUrl;
  final DateTime sentTime;
  final String messageId;
  final String? collapseKey;
  final Map<String, dynamic> data;
  final String? type;
  final String? refId;
  bool isRead = false;

  SavedNotification(
      this.title,
      this.body,
      this.imgUrl,
      this.sentTime,
      this.messageId,
      this.collapseKey,
      this.data,
      this.type,
      this.refId,
      this.isRead,
      );

  factory SavedNotification.fromJson(Map<String, dynamic> json) => _$SavedNotificationFromJson(json);

  Map<String, dynamic> toJson() => _$SavedNotificationToJson(this);
}
