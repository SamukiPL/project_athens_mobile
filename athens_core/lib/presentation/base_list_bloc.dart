import 'package:athens_core/domain/data_mapper.dart';
import 'package:athens_core/domain/list/base_model.dart';
import 'package:athens_core/domain/list/base_params.dart';
import 'package:athens_core/domain/list/list_use_case.dart';
import 'package:athens_core/domain/result.dart';
import 'package:athens_core/presentation/base_bloc.dart';
import 'package:athens_core/presentation/base_item_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:pagination/paging_bloc.dart';
import 'package:pagination/paging_list_adapter.dart';

abstract class BaseListBloc<MODEL extends BaseModel, ITEM extends BaseItemViewModel,
    PARAMS extends BaseParams> extends BaseBloc implements PagingBloc<ITEM> {
  final ListUseCase<MODEL, PARAMS> _listUseCase;

  final PARAMS _params;

  final DataMapper<MODEL, ITEM> _itemMapper;

  BaseListBloc(this._listUseCase, this._params, this._itemMapper) {
    getItems();
  }

  @override
  int batchSize = 20;

  @override
  int page = 0;

  Function itemClick;

  @protected
  Future<void> getItems() async {
    _listUseCase.getItems(_params).listen((Result data) {
      manageState(data);
      if (data is Success<List<MODEL>>)
        adapter.updateList(_mapItems(data.result));
    });
    page++;
  }

  @override
  Future<void> loadMore() async {
    adapter.setLoading(true);
    await _listUseCase.fetchItems(batchSize, page * batchSize);
  }

  @override
  Future<void> refresh() async {
    adapter.updateList(List<ITEM>(), loading: true);
    _listUseCase.refreshItems();
  }

  List<ITEM> _mapItems(List<MODEL> data) {
    return data.map((model) {
      ITEM item = _itemMapper.transform(model);
      item.itemClick = itemClick;
      return item;
    }).toList();
  }

  @override
  void dispose() {
    super.dispose();
    adapter.dispose();
  }
}
