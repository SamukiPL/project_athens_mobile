import 'paging_list_adapter.dart';

abstract class PagingBloc {

  abstract int offset;

  abstract int batchSize;

  abstract PagingListAdapter adapter;

  Future<void> loadMore();

  Future<void> refresh();

}
