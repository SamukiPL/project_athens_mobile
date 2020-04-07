import 'paging_list_adapter.dart';

abstract class PagingBloc<ITEM> {

  int page;

  int batchSize;

  PagingListAdapter<ITEM> adapter;

  void loadMore();

}
