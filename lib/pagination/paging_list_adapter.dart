import 'dart:async';

import 'package:rxdart/rxdart.dart';

import 'paging_state.dart';
import 'paging_bloc.dart';

class PagingListAdapter<ITEM> {

  final PagingBloc<ITEM> _bloc;

  PagingListAdapter(this._bloc);

  List<ITEM> _itemsList = List();

  bool _loading;

  int get _itemsCount => _itemsList.length + (_loading ? 1 : 0);

  final StreamController<PagingState<ITEM>> _stateController = BehaviorSubject();

  Stream<PagingState<ITEM>> get stateStream => _stateController.stream;

  void updateList(List<ITEM> itemsList, {bool loading = false}) {
    _itemsList = itemsList;
    _loading = loading;
    _addStateToStream();
  }

  Future<void> refresh()  {
    return _bloc.refresh();
  }

  void setLoading(bool loading) {
    _loading = loading;
    _addStateToStream();
  }

  void loadMoreData() {
    _bloc.loadMore();
  }

  void _addStateToStream() {
    _stateController.add(PagingState(_itemsList, _itemsCount, _loading));
  }

  void dispose() {
    _stateController.close();
  }

}