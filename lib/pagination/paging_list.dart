import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:provider/provider.dart';

import 'paging_list_adapter.dart';
import 'paging_state.dart';

abstract class PagingList<ITEM> extends StatelessWidget {

  @protected
  final double leftPadding = 8;
  @protected
  final double topPadding = 8;
  @protected
  final double rightPadding = 8;
  @protected
  final double bottomPadding = 8;

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
          child: getList(_adapter, state),
        )
            : getList(_adapter, state),
      ),
    );
  }

  @protected
  Widget getList(PagingListAdapter adapter, PagingState<ITEM> state) {
    return ListView.separated(
      controller: adapter.scrollController,
      separatorBuilder: (context, index) => buildSeparator(context, index),
      padding: EdgeInsets.only(left: leftPadding, top: topPadding, right: rightPadding, bottom: bottomPadding),
      itemCount: state.itemsCount,
      itemBuilder: (_, index) => _itemBuilder(state.items, index)
    );
  }

  StatelessWidget _itemBuilder(List<ITEM> items, int index) {
    if (items.length > index)
      return getItemViewHolder(items[index], index, items.length);
    else
      return progressView;
  }

  @protected
  StatelessWidget getItemViewHolder(ITEM item, int index, int length);

  @protected
  StatelessWidget buildSeparator(context, index) => Container();

}