import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/deputies_utils/domain/parliament_club_model.dart';

abstract class GetParliamentClubsRepository {

  Future<Result<List<ParliamentClubModel>>> getParliamentClubs();
}
