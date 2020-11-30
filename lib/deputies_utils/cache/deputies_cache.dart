import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/ext/map_extension.dart';
import 'package:project_athens/deputies_utils/domain/base_deputies_params.dart';
import 'package:project_athens/deputies_utils/domain/deputy_model.dart';
import 'package:project_athens/deputies_utils/domain/get_deputies/get_deputies_use_case.dart';

class DeputiesCache {
  final GetDeputiesUseCase _getDeputiesUseCase;

  DeputiesCache(this._getDeputiesUseCase);

  List<DeputyModel> _cachedDeputies;
  Map<String, String> _deputiesThumbnails = Map<String, String>();

  Future<Result<List<DeputyModel>>> result;

  Future<Result<List<DeputyModel>>> get deputies async {
    if (_cachedDeputies != null) return Success(_cachedDeputies.toList());
    if (result != null) return result;

    result = _getDeputiesUseCase(BaseDeputiesParams(9)).then((result) {
      if (result is Success<List<DeputyModel>>)
        _cachedDeputies = result.value;
      else
        this.result = null;
      return result;
    });

    return result;
  }

  Future<DeputyModel> getDeputyModel(String id) async {
    if (_cachedDeputies.isNotEmpty)
      return _cachedDeputies.firstWhere(
              (element) => element.id == id)
      ;

    await deputies;
    return _cachedDeputies.firstWhere((element) => element.id == id);
  }

  Future<String> getDeputyThumbnail(String id) async {
    if (_deputiesThumbnails.containsKey(id)) return _deputiesThumbnails[id];

    final result = await deputies;
    String thumbnailUrl;
    if (result is Success<List<DeputyModel>>) {
      thumbnailUrl = result.value?.firstWhere((element) => element.id == id,
          orElse: () => null)
          ?.thumbnailUrl;
      _deputiesThumbnails.putIfNotNull(id, thumbnailUrl);
    }

    return thumbnailUrl;
  }
}
