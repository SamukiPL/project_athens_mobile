import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'paging_list_adapter.dart';
import 'paging_state.dart';

abstract class PagingList<ITEM> extends StatelessWidget {

  final PagingListAdapter<ITEM> _adapter;

  const PagingList(this._adapter, {Key key}) : super(key: key);

  StatelessWidget get progressView;


  Widget build(BuildContext context) {
    return StreamProvider.value(
      initialData: PagingState<ITEM>(List<ITEM>(), 1),
      value: _adapter.stateStream,
      child: Consumer<PagingState<ITEM>>(
        builder: (context, state, _) => ListView.builder(
            itemCount: state.itemsCount,
            itemBuilder: (_, index) => _itemBuilder(state.items, index),
        ),
      ),
    );
  }

  StatelessWidget _itemBuilder(List<ITEM> items, int index) {
    if (items.length - 7 == index)
      _adapter.loadMoreData();
    
    if (items.length > index)
      return getItemViewHolder(items[index]);
    else
      return progressView;
  }

  StatelessWidget getItemViewHolder(ITEM item);

}