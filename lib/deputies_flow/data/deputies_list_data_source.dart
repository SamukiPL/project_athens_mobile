import 'package:project_athens/athens_core/data/base_list/network_data_source.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/deputies_flow/domain/deputies_list_params.dart';
import 'package:project_athens/deputies_utils/cache/deputies_cache.dart';
import 'package:project_athens/deputies_utils/domain/deputy_model.dart';
import 'package:project_athens/athens_core/ext/string_extension.dart';

class DeputiesListDataSource extends NetworkListDataSource<DeputyModel, DeputiesListParams> {

  final DeputiesCache _deputiesCache;

  DeputiesListDataSource(this._deputiesCache);

  @override
  Future<Result<List<DeputyModel>>> call(DeputiesListParams params) async {
    final deputiesResult = await _deputiesCache.deputies;
    if (deputiesResult is Success<List<DeputyModel>> && params.searchQuery.isNotEmpty) {
      final deputies = deputiesResult.value.where((element) => element.name.containsIgnoreCase(params.searchQuery)).toList();
      return Success(deputies);
    } else {
      return deputiesResult;
    }
  }

}