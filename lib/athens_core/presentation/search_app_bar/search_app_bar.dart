import 'package:project_athens/athens_core/presentation/search_app_bar/search_app_bar_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

PreferredSize SearchAppBar(
    {@required String title,
    @required String hintText,
    @required ValueChanged<String> searchQuery,
    @required bool showBackArrow,
    List<IconButton> additionalIcons = const []}) {
  return PreferredSize(
    preferredSize: Size.fromHeight(kToolbarHeight),
    child: _SearchAppBar(
        title: title,
        hintText: hintText,
        searchQuery: searchQuery,
        showBackArrow: showBackArrow,
        additionalIcons: additionalIcons),
  );
}

class _SearchAppBar extends StatelessWidget {
  final String title;

  final String hintText;

  final ValueChanged<String> searchQuery;

  final bool showBackArrow;

  final List<IconButton> additionalIcons;

  const _SearchAppBar(
      {Key key,
      @required this.title,
      @required this.hintText,
      @required this.searchQuery,
      @required this.showBackArrow,
      this.additionalIcons = const []})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchAppBarBloc>(
      create: (_) => SearchAppBarBloc(),
      child: Consumer<SearchAppBarBloc>(
        builder: (context, bloc, _) => AppBar(
          title: _buildAppBarTitle(bloc),
          actions: <Widget>[
                _buildAppBarIcon(bloc),
              ] +
              additionalIcons,
        ),
      ),
    );
  }

  Widget _buildAppBarTitle(SearchAppBarBloc bloc) {
    switch (bloc.state) {
      case SearchAppBarState.SEARCHING:
        return TextFormField(
          initialValue: "",
          onChanged: searchQuery,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              hintText: hintText),
        );
        break;
      default:
        return Text(
          title,
          style: TextStyle(color: Colors.white),
        );
    }
  }

  Widget _buildAppBarIcon(SearchAppBarBloc bloc) {
    switch (bloc.state) {
      case SearchAppBarState.SEARCHING:
        return IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.white,
          ),
          onPressed: () {
            searchQuery("");
            bloc.setState(SearchAppBarState.DEFAULT);
          },
        );
        break;
      default:
        return IconButton(
          icon: Icon(
            Icons.search,
            color: Colors.white,
          ),
          onPressed: () {
            bloc.setState(SearchAppBarState.SEARCHING);
          },
        );
    }
  }
}
