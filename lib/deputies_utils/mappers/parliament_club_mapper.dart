import 'package:project_athens/athens_core/domain/data_mapper.dart';
import 'package:project_athens/deputies_utils/data/network/response/parliament_club_response.dart';
import 'package:project_athens/deputies_utils/domain/parliament_club_model.dart';

class ParliamentClubMapper extends DataMapper<ParliamentClubBean, ParliamentClubModel> {
  ParliamentClubMapper();

  @override
  ParliamentClubModel transform(ParliamentClubBean data) {
    return ParliamentClubModel(id: data.id, name: data.name, imageSrc: data.imageSrc, shortName: data.shortName, createAt: data.createAt, updateAt: data.updateAt, cadency: data.cadency);
  }
}