import 'package:project_athens/athens_core/data/word_model/noun_tag.dart';
import 'package:project_athens/athens_core/data/word_model/word_model.dart';
import 'package:project_athens/athens_core/data/word_model/word_model_mapper.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/ext/map_extension.dart';
import 'package:project_athens/deputies_utils/data/network/response/deputy_nouns_response.dart';
import 'package:project_athens/deputies_utils/data/network/response/deputy_response.dart';
import 'package:project_athens/deputies_utils/domain/base_deputies_params.dart';
import 'package:project_athens/deputies_utils/domain/base_deputy_params.dart';
import 'package:project_athens/deputies_utils/domain/base_parliament_clubs_params.dart';
import 'package:project_athens/deputies_utils/domain/deputy_full.dart';
import 'package:project_athens/deputies_utils/domain/deputy_full_mapper.dart';
import 'package:project_athens/deputies_utils/domain/deputy_model.dart';
import 'package:project_athens/deputies_utils/domain/get_deputies/get_deputies_use_case.dart';
import 'package:project_athens/deputies_utils/domain/get_deputy/get_deputy_use_case.dart';
import 'package:project_athens/deputies_utils/domain/get_deputy_nouns/get_deputy_nouns_use_case.dart';
import 'package:project_athens/deputies_utils/domain/get_parliament_clubs/get_parliament_clubs_use_case.dart';
import 'package:project_athens/deputies_utils/domain/parliament_club_model.dart';

class DeputiesCache {
  final GetDeputiesUseCase _getDeputiesUseCase;
  final GetParliamentClubsUseCase _getParliamentClubsUseCase;
  final GetDeputyUseCase _getDeputyUseCase;
  final GetDeputyNounsUseCase _getDeputyNounsUseCase;

  DeputiesCache(this._getDeputiesUseCase, this._getParliamentClubsUseCase, this._getDeputyUseCase, this._getDeputyNounsUseCase);

  List<DeputyModel> _cachedDeputies;
  List<ParliamentClubModel> _cachedParliamentClubs;
  Map<String, String> _deputiesThumbnails = Map<String, String>();

  Map<String, DeputyFull> _cachedDeputiesResponse = Map<String, DeputyFull>();
  Map<String, List<WordModel>> _cachedDeputyNouns = new Map<String, List<WordModel>>();

  Future<Result<List<DeputyModel>>> get deputies async {
    if (_cachedDeputies != null) return Success(_cachedDeputies.toList());

    // final clubs =
    //     (await parliamentClubs as Success<List<ParliamentClubModel>>)?.value ?? List();

    final clubsResponse = await parliamentClubs;

    if (clubsResponse is Failure<List<ParliamentClubModel>>) {
      return Failure(clubsResponse.exception);
    }

    final clubs = (clubsResponse as Success<List<ParliamentClubModel>>)?.value;

    final result = await _getDeputiesUseCase(BaseDeputiesParams(9)).then((result) {
      if (result is Success<List<DeputyResponse>>) {
        _cachedDeputies = result.value.map((deputy) => _responseToModel(
            deputy, clubs.firstWhere((club) => club.id == deputy.parliamentClub))).toList();
        return Success(_cachedDeputies);
      } else {
        return result;
      }
    });

    return result;
  }

  Future<Result<List<ParliamentClubModel>>> get parliamentClubs async {
    if (_cachedParliamentClubs != null)
      return Success(_cachedParliamentClubs.toList());

    final clubsResult = await _getParliamentClubsUseCase(BaseParliamentClubsParams(9))
        .then((clubsResult) {
      if (clubsResult is Success<List<ParliamentClubModel>>) {
        _cachedParliamentClubs = clubsResult.value;
        return Success(_cachedParliamentClubs);
      } else {
        return clubsResult;
      }
    });

    return clubsResult;
  }

  DeputyModel _responseToModel(
          DeputyResponse response, ParliamentClubModel club) =>
      DeputyModel(
          id: response.id,
          name: response.name,
          thumbnailUrl: response.photoUrl,
          clubId: response.parliamentClub,
          club: club.shortName,
          cardId: response.cardId);

  Future<DeputyModel> getDeputyModelById(String id) =>
      _getDeputyModel((model) => model.id == id);

  Future<DeputyModel> getDeputyModelByCardId(int cardId) =>
      _getDeputyModel((model) => model.cardId == cardId);

  Future<DeputyModel> _getDeputyModel(bool Function(DeputyModel) condition) async {
    if (_cachedDeputies != null && _cachedDeputies.isNotEmpty)
      return _cachedDeputies.firstWhere((element) => condition(element));

    await deputies;

    return _cachedDeputies.firstWhere((element) => condition(element));
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
    if (_cachedParliamentClubs != null && _cachedParliamentClubs.isNotEmpty)
      return _cachedParliamentClubs.firstWhere((element) => element.id == id);

    await parliamentClubs;

    return _cachedParliamentClubs.firstWhere((element) => element.id == id);
  }

  Future<Result<DeputyFull>> getDeputyFull(String id) async {
    if (_cachedDeputiesResponse.containsKey(id)) {
      return Success(_cachedDeputiesResponse[id]);
    }

    final result = await _getDeputyUseCase(BaseDeputyParams(9, id)).then((result) async {
      if (result is Success<DeputyResponse>) {
        final clubs = await parliamentClubs;

        if (clubs is Success<List<ParliamentClubModel>>) {
          final deputyFullMapper = DeputyFullMapper((clubs as Success<List<ParliamentClubModel>>).value);
          final deputyFull = deputyFullMapper.transform(result.value);

          _cachedDeputiesResponse.putIfNotNull(deputyFull.id, deputyFull);

          final res = Success<DeputyFull>(deputyFull);

          return res;
        } else {
          return null;
        }
      } else {
        return null;
      }
    });

    return result as Result<DeputyFull>;
  }

  Future<Result<List<WordModel>>> getDeputyNouns(String id) async {
    if (_cachedDeputyNouns.containsKey(id)) {
      return Success(_cachedDeputyNouns[id]);
    }

    final result = await _getDeputyNounsUseCase(BaseDeputyParams(9, id)).then((result) async {
      if (result is Success<List<WordModel>>) {
        final words = result.value;

        _cachedDeputyNouns.putIfNotNull(id, words);

        final res = Success(words);

        return res;
      } else {
        return null;
      }
    });

    return result as Result<List<WordModel>>;
  }
}
