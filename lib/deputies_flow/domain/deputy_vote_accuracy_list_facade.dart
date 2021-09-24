import 'package:project_athens/athens_core/domain/base_list/items_repository.dart';
import 'package:project_athens/athens_core/domain/base_list/list_facade.dart';
import 'package:project_athens/athens_core/presentation/search_app_bar/search_app_bar_facade.dart';
import 'package:project_athens/deputies_flow/domain/details/deputy_vote_accuracy_list_params.dart';
import 'package:project_athens/deputies_flow/domain/vote_accuracy_alignment_enum.dart';

class DeputyVoteAccuracyListFacade extends ListFacade<DeputyVoteAccuracyListParams> with SearchAppBarFacade {
  final String cadencyDeputyId;
  final String parliamentClubId;
  final VoteAccuracyAlignment accuracyType;

  DeputyVoteAccuracyListFacade(this.cadencyDeputyId, this.parliamentClubId, this.accuracyType, ItemsRepository itemsRepository) : super(itemsRepository);

  @override
  DeputyVoteAccuracyListParams getParams({int limit = 20, int offset = 0}) => DeputyVoteAccuracyListParams(
    cadencyDeputyId: this.cadencyDeputyId,
    accuracyType: this.accuracyType,
    parliamentClubId: this.parliamentClubId,
    limit: limit,
    offset: offset,
    sortingParam: 'ASC',
    searchQuery: ''
  );
}
