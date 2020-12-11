import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/presentation/no_data/no_data.dart';
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

  final String noDataText;

  const PagingList(this._adapter, {Key key, this.noDataText}) : super(key: key);

  StatelessWidget get progressView;

  Widget build(BuildContext context) {
    return StreamProvider.value(
      initialData: PagingState<ITEM>(List<ITEM>(), 1, true),
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

  @protected
  Widget getList(PagingState<ITEM> state) {
    if (state.loading) {
      return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            progressView
          ],
        ),
      );
      return progressView;
    } else {
      if (state.items.length == 0) {
        return NoData(text: this.noDataText, color: Color.fromRGBO(0, 0, 0, 0.25));
      } else {
        return ListView.separated(
            separatorBuilder: (context, index) => buildSeparator(context, index),
            padding: EdgeInsets.only(left: leftPadding, top: topPadding, right: rightPadding, bottom: bottomPadding),
            itemCount: state.itemsCount,
            itemBuilder: (_, index) => _itemBuilder(state.items, index)
        );
      }
    }
  }


  StatelessWidget _itemBuilder(List<ITEM> items, int index) {
    if (items.length - 7 == index)
      _adapter.loadMoreData();

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