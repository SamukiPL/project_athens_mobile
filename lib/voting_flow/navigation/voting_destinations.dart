import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/data/vote/vote_slim_model.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/athens_core/navigation/bottom_navigation_bloc.dart';
import 'package:project_athens/athens_core/navigation/destination_manager.dart';
import 'package:project_athens/voting_flow/injections/vote_details_module.dart';
import 'package:project_athens/voting_flow/injections/votes_list_module.dart';
import 'package:project_athens/voting_flow/screens/details/vote_details_screen.dart';
import 'package:project_athens/voting_flow/screens/list/votes_list_screen.dart';

class VotesListDestination extends Destination<VotesListScreen> {

  VotesListDestination() : super(BottomNavItem.VOTING);
  
  @override
  VotesListScreen getScreen() => VotesListScreen();

  @override
  List<Module> getScreenModules(BuildContext context) => [VotesListModule(context)];

  @override
  bool operator ==(Object other) => other is VotesListDestination;

  @override
  int get hashCode => super.hashCode;
}

class VoteDetailsDestination extends Destination<VoteDetailsScreen> {

  final VoteSlimModel _voteModel;

  VoteDetailsDestination(this._voteModel): super(BottomNavItem.VOTING);

  @override
  VoteDetailsScreen getScreen() => VoteDetailsScreen(_voteModel);

  @override
  List<Module> getScreenModules(BuildContext context) => [VoteDetailsModule(context, _voteModel)];

  @override
  bool operator ==(Object other) => other is VoteDetailsDestination && other._voteModel == _voteModel;

  @override
  int get hashCode => Object.hashAll([_voteModel]);
}
