import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/presentation/base_item_view_model.dart';
import 'package:project_athens/athens_core/presentation/base_list/base_items_view_models/base_progress_view_model.dart';
import 'package:provider/provider.dart';

import 'paging_list_adapter.dart';
import 'paging_state.dart';

class PagingList extends StatelessWidget {
  final double leftPadding;
  final double topPadding;
  final double rightPadding;
  final double bottomPadding;

  final bool refreshable;
  final bool paginationIncluded;

  final PagingListAdapter _adapter;

  final Widget? separator;

  const PagingList(this._adapter,
      {Key? key,
        this.leftPadding = 16,
        this.topPadding = 8,
        this.rightPadding = 16,
        this.bottomPadding = 8,
        this.refreshable = false,
        this.paginationIncluded = true,
        this.separator})
      : super(key: key);

  Widget build(BuildContext context) {
    return StreamProvider.value(
      initialData: PagingState<BaseItemViewModel>([BaseProgressViewModel()]),
      value: _adapter.stateStream,
      child: Consumer<PagingState<BaseItemViewModel>>(
        builder: (context, state, _) => refreshable
            ? RefreshIndicator(
          onRefresh: () => _adapter.refresh(),
          child: getList(_adapter, state),
        )
            : getList(_adapter, state),
      ),
    );
  }

  Widget getList(
      PagingListAdapter adapter, PagingState<BaseItemViewModel> state) {
    return ListView.separated(
        separatorBuilder: (context, index) => separator ?? Container(),
        padding: EdgeInsets.only(
            left: leftPadding,
            top: topPadding,
            right: rightPadding,
            bottom: bottomPadding),
        itemCount: state.items.length,
        itemBuilder: (_, index) => _itemBuilder(state.items, index));
  }

  Widget _itemBuilder(List<BaseItemViewModel> items, int index) {
    if (items.length - 7 == index) {
      _adapter.paginationController.loadMore();
    }

    return items[index].buildWidget(index, items.length);
  }
}
