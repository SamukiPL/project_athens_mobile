import 'package:project_athens/athens_core/domain/base_list/base_model.dart';
import 'package:project_athens/athens_core/domain/base_list/list_facade.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/presentation/base_blocs/base_bloc.dart';
import 'package:project_athens/athens_core/presentation/base_item_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/presentation/base_list/item_view_model_factory.dart';
import 'package:project_athens/athens_core/presentation/data_loading/data_loading_state.dart';
import 'package:project_athens/athens_core/presentation/widget_state.dart';
import 'package:project_athens/pagination/paging_bloc.dart';
import 'package:project_athens/pagination/paging_list_adapter.dart';

class BaseListBloc extends BaseBloc implements PagingBloc {
  final ListFacade _listUseCase;

  final ItemViewModelFactory _itemFactory;

  BaseListBloc(this._listUseCase, this._itemFactory) {
    getItems();
    adapter = PagingListAdapter(this);
  }

  @override
  late PagingListAdapter adapter;

  @override
  int batchSize = 20;

  @override
  int offset = 0;

  @override
  void manageState(Result result) {
    if (result is Success<List<BaseModel>>) {
      stateController.add(WidgetState.success());
      offset = adapter.updateList(_mapItems(result.value));
      setLoadingState((result.value.isEmpty)
          ? DataLoadingState.noData()
          : DataLoadingState.contentLoaded());
    } else if(result is Refresh<List<BaseModel>>) {
      adapter.updateList([], loading: true);
    } else if (result is Failure<List<BaseModel>> && result.value != null && result.value!.isNotEmpty) {
      adapter.setLoading(false);
    } else {
      super.manageState(result);
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

  List<BaseItemViewModel> _mapItems(List<BaseModel> data) {
    return data.map((model) {
      BaseItemViewModel item = _itemFactory.create(model);
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
