import 'package:project_athens/athens_core/domain/data_mapper.dart';
import 'package:project_athens/athens_core/domain/list/base_model.dart';
import 'package:project_athens/athens_core/domain/list/base_params.dart';
import 'package:project_athens/athens_core/domain/list/list_facade.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/presentation/base_blocs/base_bloc.dart';
import 'package:project_athens/athens_core/presentation/base_item_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/presentation/data_loading/data_loading_state.dart';
import 'package:project_athens/pagination/paging_bloc.dart';
import 'package:project_athens/pagination/paging_list_adapter.dart';

abstract class BaseListBloc<
    MODEL extends BaseModel,
    ITEM extends BaseItemViewModel,
    PARAMS extends BaseParams> extends BaseBloc implements PagingBloc<ITEM> {
  final ListFacade<MODEL, PARAMS> _listUseCase;

  final DataMapper<MODEL, ITEM> _itemFactory;

  BaseListBloc(this._listUseCase, this._itemFactory) {
    getItems();
    adapter = PagingListAdapter(this);
  }

  @override
  PagingListAdapter<ITEM> adapter;

  @override
  int batchSize = 20;

  @override
  int offset = 0;

  Function(MODEL) get itemClick;

  @override
  void manageState(Result result) {
    super.manageState(result);
    if (result is Success<List<MODEL>>) {
      offset = adapter.updateList(_mapItems(result.value));
      setLoadingState((result.value.isEmpty)
          ? DataLoadingState.noData()
          : DataLoadingState.contentLoaded());
    } else if(result is Refresh<List<MODEL>>) {
      adapter.updateList(List<ITEM>(), loading: true);
    } else {
      adapter.setLoading(false);
    }
  }

  @protected
  Future<void> getItems() async {
    _listUseCase.getItems().listen((Result data) {
      adapter.setLoading(false);
      manageState(data);
    });
  }

  @override
  Future<void> loadMore() {
    adapter.setLoading(true);
    return _listUseCase.fetchItems(batchSize, offset);
  }

  @override
  Future<void> refresh() async {
    _listUseCase.refreshItems();
  }

  List<ITEM> _mapItems(List<MODEL> data) {
    return data.map((model) {
      ITEM item = _itemFactory.transform(model);
      item.itemClick = () {
        return itemClick(model);
      };
      return item;
    }).toList();
  }

  @override
  void dispose() {
    super.dispose();
    adapter.dispose();
    _listUseCase.dispose();
  }
}
