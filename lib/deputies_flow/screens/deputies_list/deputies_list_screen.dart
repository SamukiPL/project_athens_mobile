import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/navigation/bottom_navigation_bloc.dart';
import 'package:project_athens/athens_core/presentation/base_screen.dart';
import 'package:project_athens/athens_core/presentation/search_app_bar/search_app_bar.dart';
import 'package:project_athens/deputies_flow/screens/deputies_list/deputies_list_bloc.dart';
import 'package:project_athens/deputies_flow/screens/deputies_list/list/deputies_list.dart';

class DeputiesListScreen extends BaseScreen<DeputiesListBloc> {
  @override
  BottomNavItem get currentBottomBarItem => BottomNavItem.DEPUTIES;

  @override
  String get appBarTitle => "Deputies";
  @override
  bool get showBackArrow => false;

  @override
  Widget buildBody(BuildContext context, DeputiesListBloc bloc) {
    return Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Container(
              height: 0,
              child: DeputiesList(bloc.adapter),
            ),
          )
        ]
    );
  }

  @override
  Widget buildFloatingActionButton(BuildContext context, DeputiesListBloc bloc) => null;

  @override
  Widget buildAppBar(BuildContext context, DeputiesListBloc bloc) {
    return SearchAppBar(title: appBarTitle, hintText: "Deputies", searchQuery: (query) {}, showBackArrow: showBackArrow);
  }

}