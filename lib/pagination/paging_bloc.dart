import 'paging_list_adapter.dart';

abstract class PagingBloc<ITEM> {

  int page;

  int batchSize;

  PagingListAdapter<ITEM> adapter;

  Future<void> loadMore();

  Future<void> refresh();

}
