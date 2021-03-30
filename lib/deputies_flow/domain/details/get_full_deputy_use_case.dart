import 'package:project_athens/athens_core/domain/async_once/async_once_use_case.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/deputies_utils/cache/deputies_cache.dart';
import 'package:project_athens/deputies_utils/domain/deputy_full.dart';

class GetFullDeputyUseCase extends AsyncOnceUseCase<DeputyFull> {

  final DeputiesCache _deputiesCache;
  final String _deputyId;

  GetFullDeputyUseCase(this._deputiesCache, this._deputyId);

  @override
  Future<Result<DeputyFull>> call() => _deputiesCache.getDeputyFull(_deputyId);

}