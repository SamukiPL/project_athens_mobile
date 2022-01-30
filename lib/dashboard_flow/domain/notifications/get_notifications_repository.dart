import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/utils/notifications/domain/notification_model.dart';

abstract class GetNotificationsRepository {

  Future<Result<List<NotificationModel>>> getNotifications();
}
