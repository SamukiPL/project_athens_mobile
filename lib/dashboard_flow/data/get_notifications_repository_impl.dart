import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/utils/notifications/domain/notification_model.dart';
import 'package:project_athens/athens_core/utils/notifications/notifications_service.dart';
import 'package:project_athens/dashboard_flow/domain/notifications/get_notifications_repository.dart';
import 'package:project_athens/dashboard_flow/mappers/notification_model_mapper.dart';

class GetNotificationsRepositoryImpl implements GetNotificationsRepository {
  GetNotificationsRepositoryImpl();

  NotificationModelMapper _mapper = NotificationModelMapper();

  @override
  Future<Result<List<NotificationModel>>> getNotifications() async {
    final response = await NotificationsService.instance!.notificationsStream.first;

    final mappedData = _mapper(response);

    return Success(mappedData);
  }


}
