import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'paging_list_adapter.dart';
import 'paging_state.dart';

abstract class PagingList<ITEM> extends StatelessWidget {

  @protected
  final double leftPadding = 16;
  @protected
  final double topPadding = 16;
  @protected
  final double rightPadding = 16;
  @protected
  final double bottomPadding = 16;

  @protected
  final bool refreshable = true;

  final PagingListAdapter<ITEM> _adapter;

  const PagingList(this._adapter, {Key key}) : super(key: key);

  StatelessWidget get progressView;

  Widget build(BuildContext context) {
    return StreamProvider.value(
      initialData: PagingState<ITEM>(List<ITEM>(), 1),
      value: _adapter.stateStream,
      child: Consumer<PagingState<ITEM>>(
        builder: (context, state, _) => refreshable
            ? RefreshIndicator(
          onRefresh: () => _adapter.refresh(),
          child: getList(state),
        )
            : getList(state),
      ),
    );
  }

  Widget getList(PagingState<ITEM> state) => ListView.builder(
    padding: EdgeInsets.only(left: leftPadding, top: topPadding, right: rightPadding, bottom: bottomPadding),
    itemCount: state.itemsCount,
    itemBuilder: (_, index) => _itemBuilder(state.items, index),
  );

  StatelessWidget _itemBuilder(List<ITEM> items, int index) {
    if (items.length - 7 == index)
      _adapter.loadMoreData();

    if (items.length > index)
      return getItemViewHolder(items[index], index, items.length);
    else
      return progressView;
  }

  StatelessWidget getItemViewHolder(ITEM item, int index, int length);

}