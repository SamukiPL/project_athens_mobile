import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/deputies_utils/data/network/response/parliament_club_response.dart';
import 'package:project_athens/deputies_utils/domain/base_parliament_clubs_params.dart';
import 'package:project_athens/deputies_utils/domain/get_parliament_clubs/get_parliament_clubs_repository.dart';
import 'package:project_athens/deputies_utils/domain/parliament_club_model.dart';

import 'network/parliament_clubs_api.dart';

class GetParliamentClubsRepositoryImpl
    implements GetParliamentClubsRepository {
  final ParliamentClubsApi _parliamentClubsApi;

  GetParliamentClubsRepositoryImpl(this._parliamentClubsApi);

  @override
  Future<Result<List<ParliamentClubModel>>> getParliamentClubs(
      BaseParliamentClubsParams params) async {
    final response = await _parliamentClubsApi.geParliamentClubs(params.cadency);

    return Success<List<ParliamentClubModel>>(
        response.parliamentClubs.map((response) => responseToModel(response)).toList());
  }

  ParliamentClubModel responseToModel(ParliamentClubBean response) =>
      ParliamentClubModel(id: response.id, name: response.name, imageSrc: response.imageSrc, shortName: response.shortName, createAt: response.createAt, updateAt: response.updateAt, cadency: response.cadency);
}
