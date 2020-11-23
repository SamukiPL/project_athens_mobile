import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project_athens/athens_core/models/voting_model.dart';
import 'package:project_athens/athens_core/navigation/bottom_navigation_bloc.dart';
import 'package:project_athens/athens_core/navigation/destination_manager.dart';
import 'package:project_athens/athens_core/presentation/base_screen.dart';
import 'package:project_athens/athens_core/presentation/search_app_bar/search_app_bar.dart';
import 'package:project_athens/voting_flow/navigation/voting_destinations.dart';
import 'package:project_athens/voting_flow/screens/list/list_impl/votes_list.dart';
import 'package:project_athens/voting_flow/screens/list/votes_list_bloc.dart';
import 'package:provider/provider.dart';

class VotesListScreen extends BaseScreen<VotesListBloc> {

  final BottomNavItem _currentBottomBarItem;

  VotesListScreen(this._currentBottomBarItem);
  
  @override
  BottomNavItem get currentBottomBarItem => _currentBottomBarItem;
  
  @override
  String get appBarTitle => "Votes";

  @override
  bool get showBackArrow => false;

  @override
  Widget buildBody(BuildContext context, VotesListBloc bloc) {
    final destinationManager = Provider.of<DestinationManager>(context);
    return StreamProvider<VotingModel>.value(
      value: bloc.goToDetails,
      updateShouldNotify: (_, model) => _goToDetails(context, model, destinationManager),
      child: Consumer<VotingModel>(
        builder: (BuildContext context, VotingModel value, Widget child) => child,
        child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Container(
                  height: 0,
                  child: VotesList(bloc.adapter),
                ),
              )
            ]
        ),
      ),
    );
  }

  @override
  Widget buildAppBar(BuildContext context, VotesListBloc bloc) {
    return SearchAppBar(title: appBarTitle, hintText: "Not ready yet", searchQuery: (query) {}, showBackArrow: showBackArrow);
  }

  @override
  Widget buildFloatingActionButton(BuildContext context, VotesListBloc bloc) => null;

  bool _goToDetails(BuildContext context, VotingModel model, DestinationManager destinationManager) {
    destinationManager.goToDestination(context, VoteDetailsDestination(_currentBottomBarItem, model));
    return false;
  }
  
}