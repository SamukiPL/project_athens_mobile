import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/filters_and_sort/data/easy_filters/easy_filters_repository.dart';
import 'package:project_athens/athens_core/filters_and_sort/domain/easy_filters/easy_filter_model.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/deputies_flow/domain/filters/deputies_easy_filter.dart';
import 'package:project_athens/deputies_utils/cache/parliament_clubs_cache.dart';
import 'package:project_athens/deputies_utils/domain/parliament_club_model.dart';

class DeputiesEasyFiltersRepository extends EasyFiltersRepository<DeputiesEasyFilter> {

  final ParliamentClubsCache _clubsCache;
  final AppLocalizations _localizations;

  DeputiesEasyFiltersRepository(this._clubsCache, this._localizations);

  @override
  Future<Result<List<EasyFilterModel<DeputiesEasyFilter>>>> getFilters() async {
    final subscribed = EasyFilterModel(title: _localizations.getText().filtersFiltersSubscribed(), filterValue: DeputiesEasyFilter.subscribed());

    final clubs = await _clubsCache.parliamentClubs.then((result) {
      if (result is Success<List<ParliamentClubModel>>) {
        return result.value.map((club) =>
          EasyFilterModel(title: club.shortName, filterValue: DeputiesEasyFilter.parliamentClub(club.id))
        ).toList();
      } else {
        Fimber.e("Something went wrong inside DeputiesEasyFiltersRepository for parliamentClubs");
      }
    }) ?? List.empty();

    return Success([subscribed] + clubs);
  }
}
