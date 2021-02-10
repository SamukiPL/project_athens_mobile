class SortingModel {

  final int id;
  final String title;
  final String param;
  final bool isChosen;

  SortingModel(this.id, this.title, this.param, this.isChosen);

  SortingModel copy(int chosenId) => SortingModel(id, title, param, chosenId == id);

  static firstSortParam() => "ASC";

}