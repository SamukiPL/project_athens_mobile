import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/presentation/base_item_view_model.dart';
import 'package:project_athens/athens_core/presentation/base_list/base_items_view_models/base_progress_view_model.dart';
import 'package:rxdart/rxdart.dart';

import 'paging_state.dart';
import 'paging_bloc.dart';

class PagingListAdapter {

  final PagingBloc _bloc;

  List<BaseItemViewModel> _itemsList = [];

  bool _loading;

  final StreamController<PagingState<BaseItemViewModel>> _stateController = BehaviorSubject();

  Stream<PagingState<BaseItemViewModel>> get stateStream => _stateController.stream;

  final ScrollController _scrollController = ScrollController();

  ScrollController get scrollController => _scrollController;
  
  final StreamController<void> _loadMore = BehaviorSubject();

  PagingListAdapter(this._bloc) {
    _loadMore.stream
      .debounceTime(Duration(milliseconds: 500))
      .listen((event) {
        loadMoreData();
    });
    _scrollController.addListener(loadMoreListener);
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
    final fetchMorePosition = 0.85 * _scrollController.position.maxScrollExtent;
    if (_scrollController.position.pixels > fetchMorePosition) {
      _scrollController.removeListener(loadMoreListener);
      _loadMore.add({});
    }
  }

  void loadMoreData() {
    _bloc.loadMore().whenComplete(() {
      _scrollController.addListener(loadMoreListener);
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