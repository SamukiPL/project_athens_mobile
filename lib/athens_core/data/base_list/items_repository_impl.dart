import 'dart:async';

import 'package:project_athens/athens_core/data/base_list/network_data_source.dart';
import 'package:project_athens/athens_core/domain/base_list/base_model.dart';
import 'package:project_athens/athens_core/domain/base_list/base_params.dart';
import 'package:project_athens/athens_core/domain/base_list/items_repository.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:rxdart/rxdart.dart';

class ItemsRepositoryImpl extends ItemsRepository {
  final NetworkListDataSource _networkDataSource;

  ItemsRepositoryImpl(this._networkDataSource);

  final StreamController<Result<List<BaseModel>>> _streamController =
      BehaviorSubject<Result<List<BaseModel>>>();

  List<BaseModel> _cache = List.empty();

  @override
  Future<void> fetchItems(BaseParams params) {
    return networkCall(params);
  }

  @override
  Stream<Result<List<BaseModel>>> getItems(BaseParams params) {
    networkCall(params);
    return _streamController.stream;
  }

  @override
  Future<void> refreshItems(BaseParams params) async {
    _cache = List.empty();
    _streamController.add(Refresh());
    networkCall(params);
  }

  Future<void> networkCall(BaseParams params) {
    return _networkDataSource(params).then((result) {
      if (result is Success<List<BaseModel>>) {
        _cache = _cache + result.value;
        _streamController.add(Success(_cache));
      } else if (result is Failure<List<BaseModel>>) {
        _streamController.add(Failure(result.exception, value: _cache));
      }
    });
  }

  @override
  void dispose() {
    _streamController.close();
  }
}
