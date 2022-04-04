import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/filters_and_sort/data/easy_filters/easy_filters_repository.dart';
import 'package:project_athens/athens_core/filters_and_sort/domain/easy_filters/easy_filter_model.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/deputies_flow/domain/filters/deputy_votes_easy_filter.dart';

class DeputyVotesEasyFiltersRepository extends EasyFiltersRepository<DeputyVotesEasyFilter> {
  final AppLocalizations _localizations;

  DeputyVotesEasyFiltersRepository(this._localizations);

  @override
  Future<Result<List<EasyFilterModel<DeputyVotesEasyFilter>>>> getFilters() async {
    final seen = EasyFilterModel(title: _localizations().universalSeen(), filterValue: DeputyVotesEasyFilter.seen());
    final notSeen =
        EasyFilterModel(title: _localizations().universalNotSeen(), filterValue: DeputyVotesEasyFilter.notSeen());

    return Success([seen, notSeen]);
  }
}
