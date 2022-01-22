import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/filters_and_sort/data/easy_filters/easy_filters_repository.dart';
import 'package:project_athens/athens_core/filters_and_sort/domain/easy_filters/easy_filter_model.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/dashboard_flow/domain/dashboard_notifications_erasy_filter.dart';

class DashboardNotificationsEasyFiltersRepository extends EasyFiltersRepository<DashboardNotificationsEasyFilter> {

  final AppLocalizations _localizations;

  DashboardNotificationsEasyFiltersRepository(this._localizations);

  @override
  Future<Result<List<EasyFilterModel<DashboardNotificationsEasyFilter>>>> getFilters() async {
    final speeches = EasyFilterModel(title: _localizations.getText().dashboardNotificationsFiltersSpeeches(), filterValue: DashboardNotificationsEasyFilter.speechesEasyFilter());
    final votes = EasyFilterModel(title: _localizations.getText().dashboardNotificationsFiltersVotes(), filterValue: DashboardNotificationsEasyFilter.votesEasyFilter());
    final notRead = EasyFilterModel(title: _localizations.getText().dashboardNotificationsFiltersNotRead(), filterValue: DashboardNotificationsEasyFilter.notReadEasyFilter());

    return Success([speeches, votes, notRead]);
  }
}
