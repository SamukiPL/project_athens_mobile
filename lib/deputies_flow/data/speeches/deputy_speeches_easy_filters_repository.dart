import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/filters_and_sort/data/easy_filters/easy_filters_repository.dart';
import 'package:project_athens/athens_core/filters_and_sort/domain/easy_filters/easy_filter_model.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/deputies_flow/domain/filters/deputy_speeches_easy_filter.dart';
import 'package:project_athens/deputies_utils/cache/parliament_clubs_cache.dart';
import 'package:project_athens/deputies_utils/domain/parliament_club_model.dart';
import 'package:project_athens/speeches_flow/domain/filters/speeches_easy_filter.dart';

class DeputySpeechesEasyFiltersRepository extends EasyFiltersRepository<DeputySpeechesEasyFilter> {
  final AppLocalizations _localizations;

  DeputySpeechesEasyFiltersRepository(this._localizations);

  @override
  Future<Result<List<EasyFilterModel<DeputySpeechesEasyFilter>>>> getFilters() async {
    final seen = EasyFilterModel(title: _localizations().universalSeen(), filterValue: DeputySpeechesEasyFilter.seen());
    final notSeen =
        EasyFilterModel(title: _localizations().universalNotSeen(), filterValue: DeputySpeechesEasyFilter.notSeen());

    return Success([seen, notSeen]);
  }
}
