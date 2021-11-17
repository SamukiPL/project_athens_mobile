import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/ext/future_extension.dart';
import 'package:project_athens/deputies_utils/cache/parliament_clubs_cache.dart';
import 'package:project_athens/deputies_utils/data/network/deputies_api.dart';
import 'package:project_athens/deputies_utils/domain/base_deputies_params.dart';
import 'package:project_athens/deputies_utils/domain/deputy_model.dart';
import 'package:project_athens/deputies_utils/domain/get_deputies/get_deputies_mapper.dart';
import 'package:project_athens/deputies_utils/domain/get_deputies/get_deputies_repository.dart';

class GetDeputiesRepositoryImpl implements GetDeputiesRepository {
  final DeputiesApi _deputiesApi;
  final ParliamentClubsCache _clubsCache;

  GetDeputiesRepositoryImpl(
      this._deputiesApi, this._clubsCache);

  @override
  Future<Result<List<DeputyModel>>> getDeputies(BaseDeputiesParams params) async {
    final clubs = await _clubsCache.parliamentClubs.onSuccessThen((success) => success.value);
    final mapper = GetDeputiesMapper(clubs);

    return _deputiesApi.getAllDeputies(params.cadency)
        .then((value) =>
            value.map((response) => mapper.transform(response)).toList())
        .then((value) => Success(value));
  }
}
