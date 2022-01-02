import 'package:project_athens/athens_core/data/base_list/network_data_source.dart';
import 'package:project_athens/athens_core/domain/base_list/base_params.dart';
import 'package:project_athens/athens_core/domain/base_list/base_params.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/models/saved_notification.dart';
import 'package:project_athens/athens_core/models/saved_notification.dart';
import 'package:project_athens/athens_core/utils/notifications_service.dart';
import 'package:project_athens/athens_core/ext/string_extension.dart';
import 'package:project_athens/dashboard_flow/domain/dashboard_notifications_erasy_filter.dart';
import 'package:project_athens/dashboard_flow/domain/dashboard_notifications_params.dart';

class DashboardNotificationsListDataSource
    extends NetworkListDataSource<SavedNotification, DashboardNotificationsParams> {

  DashboardNotificationsListDataSource();

  @override
  Future<Result<List<SavedNotification>>> call(DashboardNotificationsParams params) async {
    var notificationsResult = Success(await NotificationsService.instance!.notificationsStream.first);
    if (notificationsResult is Success<List<SavedNotification>>) {
      notificationsResult = _filterBySearchQuery(notificationsResult, params.searchQuery);
      notificationsResult = _filterByEasyFilter(notificationsResult, params.easyFilter);
    }
    return notificationsResult;
  }

  Success<List<SavedNotification>> _filterBySearchQuery(
      Success<List<SavedNotification>> result, String searchQuery) {
    if (searchQuery.isNotEmpty) {
      final notifications = result.value
          .where((element) => element.title.containsIgnoreCase(searchQuery))
          .toList();
      return Success(notifications);
    } else {
      return result;
    }
  }

  Success<List<SavedNotification>> _filterByEasyFilter(
      Success<List<SavedNotification>> result,
      DashboardNotificationsEasyFilter? easyFilter) {
    if (easyFilter is SpeechesEasyFilter) {
      final notifications = result.value
          .where((element) => element.type == 'SPEECH')
          .toList();
      return Success(notifications);
    } else if (easyFilter is VotesEasyFilter) {
      final notifications = result.value
          .where((element) => element.type == 'VOTE')
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
