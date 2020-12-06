import 'package:project_athens/athens_core/domain/base_repository.dart';
import 'package:project_athens/athens_core/domain/base_use_case.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/deputies_utils/domain/get_parliament_clubs/get_parliament_clubs_repository.dart';
import 'package:project_athens/deputies_utils/domain/parliament_club_model.dart';

import '../base_parliament_clubs_params.dart';

class GetParliamentClubsUseCase extends BaseUseCase<BaseParliamentClubsParams> {

  final GetParliamentClubsRepository _repository;

  GetParliamentClubsUseCase(this._repository);

  @override
  Future<Result<List<ParliamentClubModel>>> call(BaseParliamentClubsParams params) {
    return _repository.getParliamentClubs(params).safeApiCall();
  }

}