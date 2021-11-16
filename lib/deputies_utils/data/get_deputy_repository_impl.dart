import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/ext/future_extension.dart';
import 'package:project_athens/deputies_utils/cache/parliament_clubs_cache.dart';
import 'package:project_athens/deputies_utils/domain/base_deputy_params.dart';
import 'package:project_athens/deputies_utils/domain/deputy_full.dart';
import 'package:project_athens/deputies_utils/domain/deputy_full_mapper.dart';
import 'package:project_athens/deputies_utils/domain/get_deputy/get_deputy_repository.dart';

import 'network/deputies_api.dart';

class GetDeputyRepositoryImpl implements GetDeputyRepository {
  final DeputiesApi _deputiesApi;
  final ParliamentClubsCache _clubsCache;
  final DeputyFullMapper _deputyFullMapper = DeputyFullMapper();

  GetDeputyRepositoryImpl(this._deputiesApi, this._clubsCache);

  @override
  Future<Result<DeputyFull>> getDeputy(BaseDeputyParams params) =>
      _clubsCache.parliamentClubs.onSuccessThen((success) {
        _deputyFullMapper.setClubs(success.value);
        return _deputiesApi.getDeputy(params.deputyId);
      }).then((value) => Success(_deputyFullMapper.transform(value)));
}
