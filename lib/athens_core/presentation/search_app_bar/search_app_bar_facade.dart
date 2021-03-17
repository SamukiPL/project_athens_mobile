mixin SearchAppBarFacade {

  String searchQuery = "";

  Future<void> changeSearchQuery(String searchQuery) async {
    this.searchQuery = searchQuery;
    refreshItems();
  }

  Future<void> refreshItems();

}