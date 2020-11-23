import 'package:flutter/src/widgets/framework.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/athens_core/models/voting_model.dart';
import 'package:project_athens/athens_core/navigation/bottom_navigation_bloc.dart';
import 'package:project_athens/athens_core/navigation/destination_manager.dart';
import 'package:project_athens/voting_flow/injections/vote_details_module.dart';
import 'package:project_athens/voting_flow/injections/votes_list_module.dart';
import 'package:project_athens/voting_flow/screens/details/vote_details_screen.dart';
import 'package:project_athens/voting_flow/screens/list/votes_list_screen.dart';

class VotesListDestination extends Destination<VotesListScreen> {

  final BottomNavItem _currentBottomBarItem;

  VotesListDestination(this._currentBottomBarItem);
  
  @override
  VotesListScreen getScreen() => VotesListScreen(_currentBottomBarItem);

  @override
  List<Module> getScreenModules(BuildContext context) => [VotesListModule(context)];
  
}

class VoteDetailsDestination extends Destination<VoteDetailsScreen> {

  final BottomNavItem _currentBottomBarItem;

  final VotingModel _votingModel;

  VoteDetailsDestination(this._currentBottomBarItem, this._votingModel);

  @override
  VoteDetailsScreen getScreen() => VoteDetailsScreen(_currentBottomBarItem, _votingModel);

  @override
  List<Module> getScreenModules(BuildContext context) => [VoteDetailsModule(context, _votingModel)];

}