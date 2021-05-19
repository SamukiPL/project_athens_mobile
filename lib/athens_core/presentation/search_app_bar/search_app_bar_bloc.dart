import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/presentation/base_blocs/base_change_notifier.dart';
import 'package:project_athens/athens_core/presentation/search_app_bar/search_app_bar_facade.dart';

class SearchAppBarBloc extends BaseChangeNotifier {

  final SearchAppBarFacade _searchAppBarFacade;

  SearchAppBarBloc(this._searchAppBarFacade);

  SearchAppBarState _state = SearchAppBarState.DEFAULT;

  SearchAppBarState get state => _state;

  FocusNode searchFocusNode = FocusNode();

  Timer _debounce;

  void setState(SearchAppBarState state) {
    _state = state;
    notifyListeners();
  }

  Future<void> changeSearchQuery(String searchQuery) async {
    if (_debounce?.isActive ?? false) _debounce.cancel();

    _debounce = Timer(const Duration(milliseconds: 400), () {
      _searchAppBarFacade.changeSearchQuery(searchQuery);
    });
  }

  @override
  void dispose() {
    searchFocusNode.dispose();
    _debounce?.cancel();
    super.dispose();
  }

}

enum SearchAppBarState { SEARCHING, DEFAULT }