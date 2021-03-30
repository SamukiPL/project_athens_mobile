class BaseParams {}

class BaseListParams extends BaseParams {
  final int limit;
  final int offset;
  final String searchQuery;
  final DateTime from;
  final DateTime to;
  final String sortingParam;

  BaseListParams({this.limit, this.offset, this.searchQuery, this.from, this.to, this.sortingParam});
}
