import 'paging_list_adapter.dart';

abstract class PagingBloc<ITEM> {

  int offset;

  int batchSize;

  PagingListAdapter<ITEM> adapter;

  Future<void> loadMore();

  Future<void> refresh();

}
