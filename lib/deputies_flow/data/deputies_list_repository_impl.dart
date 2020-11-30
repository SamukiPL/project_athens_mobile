import 'dart:async';

import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/deputies_flow/domain/deputies_list_params.dart';
import 'package:project_athens/deputies_flow/domain/deputies_list_repository.dart';
import 'package:project_athens/deputies_utils/cache/deputies_cache.dart';
import 'package:project_athens/deputies_utils/domain/deputy_model.dart';
import 'package:rxdart/rxdart.dart';

class DeputiesListRepositoryImpl extends DeputiesListRepository {

  final DeputiesCache _deputiesCache;

  DeputiesListRepositoryImpl(this._deputiesCache);

  final StreamController<Result<List<DeputyModel>>> _deputiesSubject = BehaviorSubject<Result<List<DeputyModel>>>();

  @override
  Future<void> fetchItems(int limit, int offset) async {}

  @override
  Stream<Result<List<DeputyModel>>> getItems(DeputiesListParams params) {
    getDeputies(params.deputyIdsToShow?.toSet());

    return _deputiesSubject.stream;
  }

  @override
  Future<void> refreshItems() async {}

  @override
  void dispose() {
    _deputiesSubject.close();
  }

  Future<void> getDeputies(Set<String> deputiesIds) async {
    Result<List<DeputyModel>> deputiesResult = await _deputiesCache.deputies;
    if (deputiesIds != null && deputiesResult is Success<List<DeputyModel>>) {
      final filteredValue = (deputiesResult as Success<List<DeputyModel>>).value.toList()
        ..removeWhere((element) => !deputiesIds.contains(element.id));
      deputiesResult = Success(filteredValue);
    }
    _deputiesSubject.add(deputiesResult);
  }

}
