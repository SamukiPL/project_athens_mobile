import 'package:project_athens/athens_core/data/base_list/network_data_source.dart';
import 'package:project_athens/athens_core/domain/base_list/base_params.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/utils/notifications/domain/notification_model.dart';
import 'package:project_athens/dashboard_flow/domain/notifications/get_notifications_use_case.dart';
import '../../athens_core/utils/notifications/data/storage/saved_notification.dart';
import '../../athens_core/utils/notifications/notifications_service.dart';
import 'package:project_athens/athens_core/ext/string_extension.dart';
import 'package:project_athens/dashboard_flow/domain/dashboard_notifications_erasy_filter.dart';
import 'package:project_athens/dashboard_flow/domain/dashboard_notifications_params.dart';

class DashboardNotificationsListDataSource
    extends NetworkListDataSource<NotificationModel, DashboardNotificationsParams> {

  GetNotificationsUseCase _getNotificationsUseCase;

  DashboardNotificationsListDataSource(this._getNotificationsUseCase);

  @override
  Future<Result<List<NotificationModel>>> call(DashboardNotificationsParams params) async {
    var notificationsResult = await _getNotificationsUseCase();

    if (notificationsResult is Success<List<NotificationModel>>) {
      notificationsResult = _filterBySearchQuery(notificationsResult, params.searchQuery);
      notificationsResult = _filterByEasyFilter(notificationsResult, params.easyFilter);
    }

    return notificationsResult;
  }

  Success<List<NotificationModel>> _filterBySearchQuery(
      Success<List<NotificationModel>> result, String searchQuery) {
    if (searchQuery.isNotEmpty) {
      final notifications = result.value
          .where((element) => element.title.containsIgnoreCase(searchQuery))
          .toList();
      return Success(notifications);
    } else {
      return result;
    }
  }

  Success<List<NotificationModel>> _filterByEasyFilter(
      Success<List<NotificationModel>> result,
      DashboardNotificationsEasyFilter? easyFilter) {
    if (easyFilter is SpeechesEasyFilter) {
      final notifications = result.value
          .where((element) => element.type == NotificationType.SPEECH)
          .toList();
      return Success(notifications);
    } else if (easyFilter is VotesEasyFilter) {
      final notifications = result.value
          .where((element) => element.type == NotificationType.VOTE)
          .toList();
      return Success(notifications);
    } else if(easyFilter is NotReadEasyFilter) {
      final notifications = result.value
          .where((element) => !element.isRead)
          .toList();
      return Success(notifications);
    } else {
      return result;
    }
  }
}
