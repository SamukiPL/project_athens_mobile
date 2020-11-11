import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project_athens/athens_core/models/timeline_model.dart';
import 'package:project_athens/athens_core/navigation/bottom_navigation_bloc.dart';
import 'package:project_athens/athens_core/presentation/base_screen.dart';
import 'package:project_athens/voting_flow/screens/details/vote_details_bloc.dart';

class VoteDetailsScreen extends BaseScreen<VoteDetailsBloc> {

  final BottomNavItem _currentBottomBarItem;

  final VotingModel _votingModel;

  VoteDetailsScreen(this._currentBottomBarItem, this._votingModel);

  @override
  BottomNavItem get currentBottomBarItem => _currentBottomBarItem;

  @override
  String get appBarTitle => "Vote";

  @override
  Widget buildBody(BuildContext context, VoteDetailsBloc bloc) {
    return Container();
  }

  @override
  Widget buildFloatingActionButton(BuildContext context, VoteDetailsBloc bloc) => null;

}