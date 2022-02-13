class BaseFetchQuery {
  final int offset;
  final int limit;
  final BaseFetchQuerySort sort;
  final String searchPhrase;

  BaseFetchQuery({required this.offset, required this.limit, this.sort = BaseFetchQuerySort.ASC, this.searchPhrase = ""});
}

enum BaseFetchQuerySort {
  ASC,
  DESC,
}
