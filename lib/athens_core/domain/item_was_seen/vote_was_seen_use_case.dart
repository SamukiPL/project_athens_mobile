import 'package:project_athens/athens_core/data/item_was_seen/seen_item_data_source.dart';
import 'package:project_athens/athens_core/domain/base_use_case.dart';
import 'package:project_athens/athens_core/domain/result.dart';

class VoteWasSeenUseCase extends BaseUseCase {
  final SeenItemDataSource _dataSource;

  VoteWasSeenUseCase(this._dataSource);

  Future<Result<void>> call(String votingId) =>
      _dataSource.setVoteWasSeen(votingId);
}
