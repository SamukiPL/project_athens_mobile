import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:project_athens/athens_core/data/base_responses/voting_response.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/filters_and_sort/data/easy_filters/easy_filters_repository.dart';
import 'package:project_athens/athens_core/filters_and_sort/domain/easy_filters/easy_filter_model.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/utils/get_vote_description_helper.dart';
import 'package:project_athens/deputies_flow/domain/filters/deputies_easy_filter.dart';
import 'package:project_athens/deputies_utils/cache/deputies_cache.dart';
import 'package:project_athens/deputies_utils/domain/parliament_club_model.dart';
import 'package:project_athens/voting_flow/domain/filters/votes_easy_filter.dart';

class VotesEasyFiltersRepository extends EasyFiltersRepository<VotesEasyFilter> {
  final AppLocalizations _localizations;
  VotesEasyFiltersRepository(this._localizations);

  @override
  Future<Result<List<EasyFilterModel<VotesEasyFilter>>>> getFilters() async {
    final List<EasyFilterModel<VotesEasyFilter>> types = VotingType.values.map((type) => EasyFilterModel(
        title: getVoteDescriptionHelper(type, _localizations),
        filterValue: VotesEasyFilter.voteType(type)
      )
    ).toList();

    return Success(types);
  }
}
