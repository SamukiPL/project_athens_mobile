import 'dart:async';

import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/ext/string_extension.dart';
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
  Future<void> fetchItems(DeputiesListParams params) async {}

  @override
  Stream<Result<List<DeputyModel>>> getItems(DeputiesListParams params) {
    getDeputies(params);

    return _deputiesSubject.stream;
  }

  @override
  Future<void> refreshItems(DeputiesListParams params) async {
    Fimber.e("Refresh");
    getDeputies(params);
  }

  @override
  void dispose() {
    _deputiesSubject.close();
  }

  Future<void> getDeputies(DeputiesListParams params) async {
    final deputiesResult = await _deputiesCache.deputies;
    if (deputiesResult is Success<List<DeputyModel>> && params.searchQuery.isNotEmpty) {
      final deputies = deputiesResult.value.where((element) => element.name.containsIgnoreCase(params.searchQuery)).toList();
      _deputiesSubject.add(Success<List<DeputyModel>>(deputies));
    } else {
      _deputiesSubject.add(deputiesResult);
    }
  }

}
