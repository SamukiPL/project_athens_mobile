import 'dart:async';

import 'package:project_athens/athens_core/presentation/base_item_view_model.dart';
import 'package:project_athens/athens_core/presentation/base_list/base_items_view_models/base_progress_view_model.dart';
import 'package:project_athens/pagination/pagination_listener.dart';
import 'package:rxdart/rxdart.dart';

import 'paging_bloc.dart';
import 'paging_state.dart';

class PagingListAdapter {

  final PagingBloc _bloc;

  List<BaseItemViewModel> _itemsList = [];

  bool _loading = false;

  final StreamController<PagingState<BaseItemViewModel>> _stateController = BehaviorSubject();

  Stream<PagingState<BaseItemViewModel>> get stateStream => _stateController.stream;

  final PaginationController _paginationController = PaginationController();

  PaginationController get paginationController => _paginationController;
  
  final StreamController<void> _loadMore = BehaviorSubject();

  PagingListAdapter(this._bloc) {
    _loadMore.stream
      .debounceTime(Duration(milliseconds: 500))
      .listen((event) {
        _loadMoreData();
    });
    _paginationController.addListener(loadMoreListener);
  }

  int updateList(List<BaseItemViewModel> itemsList, {bool loading = false}) {
    _itemsList = itemsList;
    _loading = loading;
    _addStateToStream();
    return itemsList.length;
  }

  Future<void> refresh()  {
    return _bloc.refresh();
  }

  void setLoading(bool loading) {
    _loading = loading;
    _addStateToStream();
  }

  void loadMoreListener() {
    //TODO Find how to use pagination without hardcoded values
    if ((_itemsList.length % 20 == 0 || _itemsList.length % 22 == 0) && _itemsList.length > 0) {
      _paginationController.removeListener(loadMoreListener);
      _loadMore.add({});
    }
  }

  void _loadMoreData() {
    _bloc.loadMore().whenComplete(() {
      _paginationController.addListener(loadMoreListener);
    });
  }

  void _addStateToStream() {
    var listToPass = _itemsList;

    if (_loading)
      listToPass = listToPass + [BaseProgressViewModel()];

    _stateController.add(PagingState(listToPass));
  }

  void dispose() {
    _stateController.close();
    _loadMore.close();
  }

}