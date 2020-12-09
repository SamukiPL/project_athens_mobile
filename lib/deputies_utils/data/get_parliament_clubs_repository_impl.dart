import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/deputies_utils/domain/base_parliament_clubs_params.dart';
import 'package:project_athens/deputies_utils/domain/get_parliament_clubs/get_parliament_clubs_repository.dart';
import 'package:project_athens/deputies_utils/domain/parliament_club_model.dart';
import 'package:project_athens/deputies_utils/mappers/parliament_club_mapper.dart';

import 'network/parliament_clubs_api.dart';

class GetParliamentClubsRepositoryImpl
    implements GetParliamentClubsRepository {
  final ParliamentClubsApi _parliamentClubsApi;

  final ParliamentClubMapper clubMapper = ParliamentClubMapper();

  GetParliamentClubsRepositoryImpl(this._parliamentClubsApi);

  @override
  Future<Result<List<ParliamentClubModel>>> getParliamentClubs(
      BaseParliamentClubsParams params) async {
    final response = await _parliamentClubsApi.geParliamentClubs(params.cadency);

    final mappedClubs = clubMapper(response.parliamentClubs);

    return Success<List<ParliamentClubModel>>(mappedClubs);
  }
}
