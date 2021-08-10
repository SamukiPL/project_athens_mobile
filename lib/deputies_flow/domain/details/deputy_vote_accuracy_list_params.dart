import 'package:project_athens/athens_core/domain/base_list/base_params.dart';
import 'package:project_athens/deputies_flow/domain/vote_accuracy_alignment_enum.dart';

class DeputyVoteAccuracyListParams extends BaseListParams {
  final String cadencyDeputyId;
  final String parliamentClubId;
  final VoteAccuracyAlignment accuracyType;

  DeputyVoteAccuracyListParams({
    this.cadencyDeputyId,
    this.parliamentClubId,
    this.accuracyType,
    int offset,
    int limit,
    String searchQuery,
    DateTime from,
    DateTime to,
    String sortingParam
  }) : super(
      limit: limit,
      offset: offset,
      searchQuery: searchQuery,
      from: from,
      to: to,
      sortingParam: sortingParam
  );
}