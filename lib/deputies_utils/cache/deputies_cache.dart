import 'package:collection/src/iterable_extensions.dart';
import 'package:project_athens/athens_core/data/word_model/word_model.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/ext/future_extension.dart';
import 'package:project_athens/athens_core/ext/map_extension.dart';
import 'package:project_athens/deputies_utils/cache/cache_errors.dart';
import 'package:project_athens/deputies_utils/domain/base_deputies_params.dart';
import 'package:project_athens/deputies_utils/domain/base_deputy_params.dart';
import 'package:project_athens/deputies_utils/domain/deputy_full.dart';
import 'package:project_athens/deputies_utils/domain/deputy_model.dart';
import 'package:project_athens/deputies_utils/domain/get_deputies/get_deputies_use_case.dart';
import 'package:project_athens/deputies_utils/domain/get_deputy/get_deputy_use_case.dart';
import 'package:project_athens/deputies_utils/domain/get_deputy_nouns/get_deputy_nouns_use_case.dart';

class DeputiesCache {
  final GetDeputiesUseCase _getDeputiesUseCase;
  final GetDeputyUseCase _getDeputyUseCase;
  final GetDeputyNounsUseCase _getDeputyNounsUseCase;

  DeputiesCache(this._getDeputiesUseCase, this._getDeputyUseCase, this._getDeputyNounsUseCase);

  List<DeputyModel>? _cachedDeputies;
  Map<String, String> _deputiesThumbnails = Map<String, String>();
  Map<String, DeputyFull> _cachedDeputiesResponse = Map<String, DeputyFull>();
  Map<String, List<WordModel>> _cachedDeputyNouns = new Map<String, List<WordModel>>();

  Future<Result<List<DeputyModel>>>? result;

  Future<Result<List<DeputyModel>>> get deputies {
    if (_cachedDeputies != null)
      return Future.value(Success(_cachedDeputies!.toList()));

    if (result != null) return result!;

    result = _getDeputiesUseCase(BaseDeputiesParams(9)).whenComplete(() {
      result = null;
    }).then((result) {
      if (result.isSuccess()) {
        _cachedDeputies = result.toSuccess().value;
        return Success(_cachedDeputies!);
      } else {
        return Failure(DeputiesCacheError());
      }
    });

    return result!;
  }

  Future<DeputyModel> getDeputyModelById(String id) =>
      _getDeputyModel((model) => model.id == id);

  Future<DeputyModel> getDeputyModelByCardId(int cardId) =>
      _getDeputyModel((model) => model.cardId == cardId);

  Future<DeputyModel> _getDeputyModel(bool Function(DeputyModel) condition) =>
      deputies.onSuccessThen((success) => success.value.firstWhere(condition));

  Future<String> getDeputyThumbnail(String id) {
    if (_deputiesThumbnails.containsKey(id))
      return Future.value(_deputiesThumbnails[id]!);

    return deputies.onSuccessThen((success) {
      final thumbnailUrl = success.value
          .firstWhereOrNull((element) => element.id == id)
          ?.thumbnailUrl;
      _deputiesThumbnails.putIfNotNull(id, thumbnailUrl!);

      return thumbnailUrl;
    });
  }

  Future<Result<DeputyFull>> getDeputyFull(String id) async {
    if (_cachedDeputiesResponse.containsKey(id)) {
      return Success(_cachedDeputiesResponse[id]!);
    }

    return _getDeputyUseCase(BaseDeputyParams(9, id)).onSuccessThen((success) {
      final deputyFull = success.value;
      _cachedDeputiesResponse.putIfNotNull(deputyFull.id, deputyFull);
      return success;
    });
  }

  Future<Result<List<WordModel>>> getDeputyNouns(String id) async {
    if (_cachedDeputyNouns.containsKey(id)) {
      return Success(_cachedDeputyNouns[id]!);
    }

    return _getDeputyNounsUseCase(BaseDeputyParams(9, id)).onSuccessThen((success) {
      final words = success.value;
      _cachedDeputyNouns.putIfNotNull(id, words);
      return Success(success.value);
    });
  }
}
