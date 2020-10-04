import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/ext/map_extension.dart';
import 'package:project_athens/deputies_utils/domain/deputy_model.dart';
import 'package:project_athens/deputies_utils/domain/get_deputies/get_deputies_params.dart';
import 'package:project_athens/deputies_utils/domain/get_deputies/get_deputies_use_case.dart';

class DeputiesCache {
  final GetDeputiesUseCase _getDeputiesUseCase;

  DeputiesCache(this._getDeputiesUseCase);

  List<DeputyModel> _cachedDeputies;
  Map<String, String> _deputiesThumbnails = Map<String, String>();

  Future<Result<List<DeputyModel>>> result;

  Future<Result<List<DeputyModel>>> get deputies async {
    if (_cachedDeputies != null) return Success(_cachedDeputies);
    if (result != null) return result;

    result = _getDeputiesUseCase(GetDeputiesParams(9)).then((value) {
      if (value is Success<List<DeputyModel>>)
        _cachedDeputies = value.result;
      else
        result = null;
      return value;
    });

    return result;
  }

  Future<String> getDeputyThumbnail(String id) async {
    if (_deputiesThumbnails.containsKey(id)) return _deputiesThumbnails[id];

    final result = await deputies;
    String thumbnailUrl;
    if (result is Success<List<DeputyModel>>) {
      thumbnailUrl = result.result?.firstWhere((element) => element.id == id,
          orElse: () => null)
          ?.thumbnailUrl;
      _deputiesThumbnails.putIfNotNull(id, thumbnailUrl);
    }

    return thumbnailUrl;
  }
}
