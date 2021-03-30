import 'paging_list_adapter.dart';

abstract class PagingBloc {

  int offset;

  int batchSize;

  PagingListAdapter adapter;

  Future<void> loadMore();

  Future<void> refresh();

}
