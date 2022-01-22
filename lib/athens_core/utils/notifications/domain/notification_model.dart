import 'package:project_athens/athens_core/domain/base_list/base_model.dart';

class NotificationModel extends BaseModel {
  final String title;
  final String? body;
  final String? imgUrl;
  final DateTime sentTime;
  final NotificationType type;
  final String? refId;
  final String? messageId;
  bool isRead;

  NotificationModel(
      this.title,
      this.body,
      this.imgUrl,
      this.sentTime,
      this.type,
      this.refId,
      this.isRead,
      this.messageId
  );
}

enum NotificationType {
  SPEECH,
  VOTE,
  DEPUTY,
  UNKNOWN
}
