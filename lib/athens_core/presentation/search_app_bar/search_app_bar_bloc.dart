import 'package:project_athens/athens_core/presentation/base_blocs/base_change_notifier.dart';

class SearchAppBarBloc extends BaseChangeNotifier {

  SearchAppBarState _state = SearchAppBarState.DEFAULT;

  SearchAppBarState get state => _state;

  void setState(SearchAppBarState state) {
    _state = state;
    notifyListeners();
  }

}

enum SearchAppBarState { SEARCHING, DEFAULT }