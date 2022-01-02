import 'package:project_athens/athens_core/domain/base_list/items_repository.dart';
import 'package:project_athens/athens_core/domain/base_list/list_facade.dart';
import 'package:project_athens/athens_core/filters_and_sort/data/easy_filters/easy_filters_repository.dart';
import 'package:project_athens/athens_core/filters_and_sort/domain/easy_filters/easy_filters_facade.dart';
import 'package:project_athens/athens_core/presentation/search_app_bar/search_app_bar_facade.dart';
import 'package:project_athens/dashboard_flow/domain/dashboard_notifications_erasy_filter.dart';
import 'package:project_athens/dashboard_flow/domain/dashboard_notifications_params.dart';

class DashboardNotificationsListFacade extends ListFacade<DashboardNotificationsParams>
    with SearchAppBarFacade, EasyFiltersFacade<DashboardNotificationsEasyFilter> {
  DashboardNotificationsListFacade(
      ItemsRepository itemsRepository, this.easyFiltersRepository)
      : super(itemsRepository);

  @override
  final EasyFiltersRepository<DashboardNotificationsEasyFilter> easyFiltersRepository;

  @override
  DashboardNotificationsParams getParams({int limit = 20, int offset = 0}) =>
      DashboardNotificationsParams(
          searchQuery: searchQuery,
          easyFilter: easyFilterValue
      );
}
