import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/ext/map_extension.dart';
import 'package:project_athens/deputies_utils/data/network/response/deputy_response.dart';
import 'package:project_athens/deputies_utils/domain/base_deputies_params.dart';
import 'package:project_athens/deputies_utils/domain/base_parliament_clubs_params.dart';
import 'package:project_athens/deputies_utils/domain/deputy_model.dart';
import 'package:project_athens/deputies_utils/domain/get_deputies/get_deputies_use_case.dart';
import 'package:project_athens/deputies_utils/domain/get_parliament_clubs/get_parliament_clubs_use_case.dart';
import 'package:project_athens/deputies_utils/domain/parliament_club_model.dart';

class DeputiesCache {
  final GetDeputiesUseCase _getDeputiesUseCase;
  final GetParliamentClubsUseCase _getParliamentClubsUseCase;

  DeputiesCache(this._getDeputiesUseCase, this._getParliamentClubsUseCase);

  List<DeputyModel> _cachedDeputies;
  List<ParliamentClubModel> _cachedParliamentClubs;
  Map<String, String> _deputiesThumbnails = Map<String, String>();

  Future<Result<List<DeputyModel>>> get deputies async {
    if (_cachedDeputies != null) return Success(_cachedDeputies.toList());

    final clubs =
        (await parliamentClubs as Success<List<ParliamentClubModel>>)?.value ?? List();

    final result = await _getDeputiesUseCase(BaseDeputiesParams(9)).then((result) {
      if (result is Success<List<DeputyResponse>>) {
        _cachedDeputies = result.value.map((deputy) => _responseToModel(
            deputy, clubs.firstWhere((club) => club.id == deputy.parliamentClub))).toList();
        return _cachedDeputies;
      } else {
        return List();
      }
    });

    return Success(result);
  }

  Future<Result<List<ParliamentClubModel>>> get parliamentClubs async {
    if (_cachedParliamentClubs != null)
      return Success(_cachedParliamentClubs.toList());

    final clubsResult = await _getParliamentClubsUseCase(BaseParliamentClubsParams(9))
        .then((clubsResult) {
      if (clubsResult is Success<List<ParliamentClubModel>>) {
        _cachedParliamentClubs = clubsResult.value;
        return _cachedParliamentClubs;
      }
      return List();
    });

    return Success(clubsResult);
  }

  DeputyModel _responseToModel(
          DeputyResponse response, ParliamentClubModel club) =>
      DeputyModel(
          id: response.id,
          name: response.name,
          thumbnailUrl: response.photoUrl,
          clubId: response.parliamentClub,
          club: club.shortName);

  Future<DeputyModel> getDeputyModel(String id) async {
    if (_cachedDeputies.isNotEmpty)
      return _cachedDeputies.firstWhere((element) => element.id == id);

    await deputies;

    return _cachedDeputies.firstWhere((element) => element.id == id);
  }

  Future<String> getDeputyThumbnail(String id) async {
    if (_deputiesThumbnails.containsKey(id)) return _deputiesThumbnails[id];

    final result = await deputies;
    String thumbnailUrl;
    if (result is Success<List<DeputyModel>>) {
      thumbnailUrl = result.value
          ?.firstWhere((element) => element.id == id, orElse: () => null)
          ?.thumbnailUrl;
      _deputiesThumbnails.putIfNotNull(id, thumbnailUrl);
    }

    return thumbnailUrl;
  }

  Future<ParliamentClubModel> getParliamentClubModel(String id) async {
    if (_cachedDeputies.isNotEmpty)
      return _cachedParliamentClubs.firstWhere((element) => element.id == id);

    await parliamentClubs;

    return _cachedParliamentClubs.firstWhere((element) => element.id == id);
  }
}
