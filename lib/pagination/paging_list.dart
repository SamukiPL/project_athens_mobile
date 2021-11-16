import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/ads/native_ad/native_ad_bloc.dart';
import 'package:project_athens/athens_core/ads/native_ad/native_ad_widget.dart';
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

  final int minimalAdIndex;
  late final NativeAdBloc? nativeAdBloc;

  PagingList(this._adapter,
      {Key? key,
      this.leftPadding = 16,
      this.topPadding = 8,
      this.rightPadding = 16,
      this.bottomPadding = 8,
      this.refreshable = false,
      this.paginationIncluded = true,
      this.separator,
      String? adFactoryId,
      this.minimalAdIndex = 5})
      : super(key: key) {
    if (adFactoryId != null) {
      nativeAdBloc = NativeAdBloc(adFactoryId: adFactoryId);
    } else {
      nativeAdBloc = null;
    }
  }

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
    final test = state.items.length +
        _getAdditionItemsCount(state.items.length);
    try {
      return ListView.separated(
          separatorBuilder: (context, index) => separator ?? Container(),
          padding: EdgeInsets.only(
              left: leftPadding,
              top: topPadding,
              right: rightPadding,
              bottom: bottomPadding),
          itemCount: state.items.length +
              _getAdditionItemsCount(state.items.length),
          itemBuilder: (_, index) => _itemBuilder(state.items, index));
    } catch(exception) {
      print("DUPA " + test.toString());
      print(exception);
      return Container();
    }
  }

  Widget _itemBuilder(List<BaseItemViewModel> items, int index) {
    if (items.length - 7 == index) {
      _adapter.paginationController.loadMore();
    }

    if (nativeAdBloc?.shouldBuildWidget == true && index >= minimalAdIndex) {
      nativeAdBloc!.changeAdIndex(index);
      return NativeAdWidget(bloc: nativeAdBloc!);
    }

    final listIndex = _getItemListIndex(index);

    return items[listIndex].buildWidget(listIndex, items.length);
  }

  int _getAdditionItemsCount(int length) => (length > 0 && nativeAdBloc != null) ? 1 : 0;

  int _getItemListIndex(int index) => (nativeAdBloc?.isVisible == true &&
          index >= (nativeAdBloc?.adIndex ?? -1) &&
          index >= minimalAdIndex)
      ? index - 1
      : index;
}
