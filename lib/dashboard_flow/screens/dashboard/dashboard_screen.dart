import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/presentation/base_screen.dart';
import 'package:project_athens/athens_core/presentation/grid/grid.dart';
import 'package:project_athens/athens_core/presentation/grid/tile.dart';
import 'package:project_athens/athens_core/presentation/grid/tiles/simple_tile/simple_tile.dart';
import 'package:project_athens/dashboard_flow/screens/dashboard/dashboard_bloc.dart';
import 'package:project_athens/dashboard_flow/screens/dashboard/tiles/nearest_meeting_tile/nearest_meeting_tile.dart';
import 'package:project_athens/dashboard_flow/screens/dashboard/tiles/nearest_meeting_tile/nearest_meeting_tile_bloc.dart';
import 'package:project_athens/dashboard_flow/screens/dashboard/tiles/user_name_tile/user_name_tile.dart';
import 'package:project_athens/deputies_flow/navigation/deputies_destinations.dart';
import 'package:project_athens/more_flow/navigation/more_navigation.dart';
import 'package:project_athens/speeches_flow/navigation/speeches_destinations.dart';
import 'package:project_athens/voting_flow/navigation/voting_destinations.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends BaseScreen<DashboardBloc> {
  DashboardScreen();

  @override
  bool get showBackArrow => false;

  @override
  bool get shouldShowBottomBar => true;

  @override
  String getAppBarTitle(AppLocalizations localizations, DashboardBloc bloc) {
    return localizations.getText().dashboardTitle();
  }

  @override
  Widget buildBody(BuildContext context, DashboardBloc bloc) {
    final _localizations = AppLocalizations.of(context);
    final nearestMeetingBloc = Provider.of<NearestMeetingTileBloc>(context);
    return Container(
      child: Grid(
        gridSize: 6,
        tiles: [
          TileData(
              tileBuilder: (BuildContext context, TileData tile) =>
                  UserNameTile(),
              order: 0,
              sizeX: 5,
              sizeY: 1),
          TileData(
              tileBuilder: (BuildContext context, TileData tile) =>
                  SimpleTile(
                    // text: _localizations!.getText().settingsSettingsTitle(),
                    icon: Icons.settings,
                    goTo: MoreScreenDestination(),
                  ),
              order: 0,
              sizeX: 1,
              sizeY: 1),
          TileData(
              tileBuilder: (BuildContext context, TileData tile) =>
                  NearestMeetingTile(nearestMeetingBloc),
              order: 0,
              sizeX: 6,
              sizeY: 2),
          TileData(
              tileBuilder: (BuildContext context, TileData tile) =>
                  SimpleTile(
                    icon: Icons.person,
                    text: _localizations!.getText().deputiesDeputiesListTitle(),
                    goTo: DeputiesListDestination()
                  ),
              order: 0,
              sizeX: 2,
              sizeY: 2),
          TileData(
              tileBuilder: (BuildContext context, TileData tile) =>
                  SimpleTile(
                      icon: Icons.record_voice_over,
                      text: _localizations!.getText().speechesSpeechesListTitle(),
                      goTo: SpeechesListDestination(),
                  ),
              order: 0,
              sizeX: 2,
              sizeY: 2),
          TileData(
              tileBuilder: (BuildContext context, TileData tile) =>
                  SimpleTile(
                      icon: MdiIcons.vote,
                      text: _localizations!.getText().votingsVotingListTitle(),
                      goTo: VotesListDestination()
                  ),
              order: 0,
              sizeX: 2,
              sizeY: 2)
        ],
      )
    );
  }

  @override
  Widget? buildFloatingActionButton(BuildContext context, DashboardBloc bloc) => null;
}