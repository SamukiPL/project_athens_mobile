import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:project_athens/athens_core/models/voting_model.dart';
import 'package:project_athens/athens_core/navigation/bottom_navigation_bloc.dart';
import 'package:project_athens/athens_core/navigation/destination_manager.dart';
import 'package:project_athens/athens_core/presentation/base_screen.dart';
import 'package:project_athens/athens_core/presentation/technical_data/technical_data.dart';
import 'package:project_athens/deputies_flow/navigation/deputies_destinations.dart';
import 'package:project_athens/voting_flow/screens/details/vote_details_bloc.dart';
import 'package:provider/provider.dart';

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
    final theme = Theme.of(context);
    final destinationManager = Provider.of<DestinationManager>(context);

    return StreamProvider<List<String>>.value(
      value: bloc.goToDeputiesList,
      updateShouldNotify: (_, current) {
        return goToDeputiesList(context, current, destinationManager);
      },
      child: Consumer<List<String>>(
        builder: (context, _, child) => child,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildInFavorAndAgainstRow(bloc),
              buildHoldAndAbsentRow(bloc),
              buildTypeAndDateRow(theme),
              buildDescription(theme),
              TechnicalData(technicalId: _votingModel.id),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget buildInFavorAndAgainstRow(VoteDetailsBloc bloc) {
    return Container(
        margin: EdgeInsets.fromLTRB(36, 16, 36, 16),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => bloc.prepareList(VoteType.IN_FAVOR),
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Za",
                        style: TextStyle(
                          fontSize: _votingModel.results.inFavor/12,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        _votingModel.results.inFavor.toString(),
                        style: TextStyle(
                            fontSize: _votingModel.results.inFavor/8,
                            color: Colors.white
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
                child: GestureDetector(
                  onTap: () => bloc.prepareList(VoteType.AGAINST),
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Przeciw",
                          style: TextStyle(
                              fontSize: _votingModel.results.against/12,
                              color: Colors.white
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          _votingModel.results.against.toString(),
                          style: TextStyle(
                              fontSize: _votingModel.results.against/8,
                              color: Colors.white
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                )
            )
          ],
        ),
      );
  }
  
  Widget buildHoldAndAbsentRow(VoteDetailsBloc bloc) {
    return Container(
        margin: EdgeInsets.only(left: 36, right: 36, bottom: 16, top: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: GestureDetector(
                  onTap: () => bloc.prepareList(VoteType.HOLD),
                  child: Column(
                    children: [
                      Text(
                        "Wstrzymało się",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                        ),
                        child: Text(
                          _votingModel.results.hold.toString(),
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                )
            ),
            Expanded(
                child: GestureDetector(
                  onTap: () => bloc.prepareList(VoteType.ABSENT),
                  child: Column(
                    children: [
                      Text(
                        "Nie głosowało",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                        ),
                        child: Text(
                          _votingModel.results.absent.toString(),
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                )
            ),
          ],
        ),
      );
  }

  Widget buildTypeAndDateRow(ThemeData theme) {
    return Container(
        margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              _votingModel.votingDesc,
              style: TextStyle(
                  color: theme.primaryColor,
                  fontSize: 18
              ),
            ),
            Text(
              DateFormat("hh:mm\nd.M.y", "pl").format(_votingModel.date),
              style: TextStyle(
                color: theme.primaryColor,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      );
  }

  Widget buildDescription(ThemeData theme) {
    return Container(
      margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
      child: Text(
        _votingModel.title,
        style: TextStyle(
            color: theme.dividerColor,
            fontSize: 22
        ),
      ),
    );
  }

  @override
  Widget buildFloatingActionButton(BuildContext context, VoteDetailsBloc bloc) => null;
  
  bool goToDeputiesList(BuildContext context, List<String> deputiesIds, DestinationManager destinationManager) {
    destinationManager.goToDestination(context, DeputiesListDestination(currentBottomItem: currentBottomBarItem, deputiesIdsToShow: deputiesIds));
    return false;
  }

}