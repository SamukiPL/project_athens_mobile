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
  final ParliamentClubsCache _parliamentClubsCache;
  final GetDeputiesMapper _mapper = GetDeputiesMapper();

  GetDeputiesRepositoryImpl(
      this._deputiesApi, this._parliamentClubsCache);

  @override
  Future<Result<List<DeputyModel>>> getDeputies(BaseDeputiesParams params) {
    return _parliamentClubsCache.parliamentClubs
        .onSuccessThen((success) {
          _mapper.setClubs(success.value);
          return _deputiesApi.getAllDeputies(params.cadency);
        })
        .then((value) =>
            value.map((response) => _mapper.transform(response)).toList())
        .then((value) => Success(value));
  }
}
