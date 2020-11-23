import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:project_athens/athens_core/models/voting_model.dart';
import 'package:project_athens/athens_core/navigation/bottom_navigation_bloc.dart';
import 'package:project_athens/athens_core/presentation/base_screen.dart';
import 'package:project_athens/deputies_utils/data/network/response/deputy_response.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Icon(
          MdiIcons.checkCircle,
          size: 150,
        ),
        Row(
          children: [
            Expanded(
                child: Container(
                  color: Colors.green,
                    child: Text(_votingModel.results.inFavor.toString())
                ),
            ),
            Expanded(
                child: Container(
                  color: Colors.blue,
                  child: Column(
                    children: [
                      Text(_votingModel.results.hold.toString()),
                      Text(_votingModel.results.absent.toString()),
                    ],
                  ),
                ),
            ),
            Expanded(
                child: Text(_votingModel.results.against.toString())
            )
          ],
        )
      ],
    );
  }

  @override
  Widget buildFloatingActionButton(BuildContext context, VoteDetailsBloc bloc) => null;

}