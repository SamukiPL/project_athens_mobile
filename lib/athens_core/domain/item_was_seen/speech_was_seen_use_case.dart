import 'package:project_athens/athens_core/data/item_was_seen/seen_item_data_source.dart';
import 'package:project_athens/athens_core/domain/base_use_case.dart';
import 'package:project_athens/athens_core/domain/result.dart';

class SpeechWasSeenUseCase extends BaseUseCase {
  final SeenItemDataSource _dataSource;

  SpeechWasSeenUseCase(this._dataSource);

  Future<Result<void>> call(String speechId) =>
      _dataSource.setSpeechWasSeen(speechId);
}