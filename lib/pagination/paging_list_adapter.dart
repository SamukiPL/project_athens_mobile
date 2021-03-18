import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:rxdart/rxdart.dart';

import 'paging_state.dart';
import 'paging_bloc.dart';

class PagingListAdapter<ITEM> {

  final PagingBloc<ITEM> _bloc;

  List<ITEM> _itemsList = List();

  bool _loading;

  int get _itemsCount => _itemsList.length + (_loading ? 1 : 0);

  final StreamController<PagingState<ITEM>> _stateController = BehaviorSubject();

  Stream<PagingState<ITEM>> get stateStream => _stateController.stream;

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

  int updateList(List<ITEM> itemsList, {bool loading = false}) {
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
    _stateController.add(PagingState(_itemsList, _itemsCount));
  }

  void dispose() {
    _stateController.close();
    _loadMore.close();
  }

}