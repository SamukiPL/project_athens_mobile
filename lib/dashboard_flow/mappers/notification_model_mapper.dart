import 'package:project_athens/athens_core/domain/data_mapper.dart';
import 'package:project_athens/athens_core/utils/notifications/data/storage/saved_notification.dart';
import 'package:project_athens/athens_core/utils/notifications/domain/notification_model.dart';

class NotificationModelMapper extends DataMapper<SavedNotification, NotificationModel> {
  NotificationModelMapper();

  @override
  NotificationModel transform(SavedNotification data) {
    return NotificationModel(
        data.title,
        data.body,
        data.imgUrl,
        data.sentTime,
        _getTypeFromString(data.type),
        data.refId,
        data.isRead,
        data.messageId
    );
  }

  NotificationType _getTypeFromString(String? type) {
    switch(type) {
      case "SPEECH": return NotificationType.SPEECH;
      case "DEPUTY": return NotificationType.DEPUTY;
      case "VOTE": return NotificationType.VOTE;
      case "UNKNOWN": return NotificationType.UNKNOWN;
      default: return NotificationType.UNKNOWN;
    }
  }
}