class BaseParams {}

class BaseListParams extends BaseParams {
  final int limit;
  final int offset;
  final String searchQuery;
  final DateTime? from;
  final DateTime? to;
  final String sortingParam;

  BaseListParams(
      {required this.limit,
      required this.offset,
      required this.searchQuery,
      this.from,
      this.to,
      required this.sortingParam});
}
