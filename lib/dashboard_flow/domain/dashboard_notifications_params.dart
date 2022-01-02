import 'package:project_athens/athens_core/domain/base_list/base_params.dart';
import 'package:project_athens/dashboard_flow/domain/dashboard_notifications_erasy_filter.dart';

class DashboardNotificationsParams extends BaseParams {

  final String searchQuery;
  final DashboardNotificationsEasyFilter? easyFilter;

  DashboardNotificationsParams({required this.searchQuery, this.easyFilter});

}
