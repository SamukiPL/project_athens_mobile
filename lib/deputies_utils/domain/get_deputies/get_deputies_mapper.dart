import 'package:project_athens/athens_core/domain/data_mapper.dart';
import 'package:project_athens/deputies_utils/data/network/response/deputy_response.dart';
import 'package:project_athens/deputies_utils/domain/deputy_model.dart';
import 'package:project_athens/deputies_utils/domain/parliament_club_model.dart';

class GetDeputiesMapper extends DataMapper<DeputyResponse, DeputyModel> {

  late List<ParliamentClubModel> _clubs;

  void setClubs(List<ParliamentClubModel> clubs) {
    _clubs = clubs;
  }

  @override
  DeputyModel transform(DeputyResponse data) =>
      DeputyModel(
          id: data.id,
          name: data.name,
          thumbnailUrl: data.photoUrl,
          clubId: data.parliamentClub,
          club: _getClubShortName(data.parliamentClub),
          cardId: data.cardId);

  String _getClubShortName(String clubId) =>
      _clubs.firstWhere((club) => club.id == clubId).shortName;
}
