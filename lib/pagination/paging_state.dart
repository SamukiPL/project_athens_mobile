
class PagingState<ITEM> {

  final List<ITEM> items;

  final int itemsCount;

  final bool loading;

  PagingState(this.items, this.itemsCount, this.loading);

}