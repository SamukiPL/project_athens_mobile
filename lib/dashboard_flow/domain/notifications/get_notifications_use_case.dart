import 'package:project_athens/athens_core/domain/base_list/base_params.dart';
import 'package:project_athens/athens_core/domain/base_use_case.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/utils/notifications/domain/notification_model.dart';
import 'package:project_athens/athens_core/domain/base_repository.dart';
import 'package:project_athens/dashboard_flow/domain/notifications/get_notifications_repository.dart';

class GetNotificationsUseCase extends BaseUseCase<BaseParams> {

  final GetNotificationsRepository repository;

  GetNotificationsUseCase(this.repository);

  @override
  Future<Result<List<NotificationModel>>> call(BaseParams params) {
    return repository.getNotifications().safeApiCall();
  }
}
