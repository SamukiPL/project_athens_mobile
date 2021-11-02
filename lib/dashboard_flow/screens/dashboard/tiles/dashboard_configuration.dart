import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/presentation/grid/tile.dart';
import 'package:project_athens/athens_core/presentation/grid/tiles/simple_tile/simple_tile.dart';
import 'package:project_athens/dashboard_flow/screens/dashboard/tiles/dashboard_tiles.dart';
import 'package:project_athens/dashboard_flow/screens/dashboard/tiles/nearest_meeting_tile/nearest_meeting_tile.dart';
import 'package:project_athens/dashboard_flow/screens/dashboard/tiles/nearest_meeting_tile/nearest_meeting_tile_bloc.dart';
import 'package:project_athens/dashboard_flow/screens/dashboard/tiles/user_name_tile/user_name_tile.dart';
import 'package:project_athens/deputies_flow/navigation/deputies_destinations.dart';
import 'package:project_athens/more_flow/navigation/more_navigation.dart';
import 'package:project_athens/speeches_flow/navigation/speeches_destinations.dart';
import 'package:project_athens/voting_flow/navigation/voting_destinations.dart';
import 'package:provider/provider.dart';

final List<TileData> allTiles = [
  TileData(
      tileBuilder: (BuildContext context, TileData tile, AppLocalizations _localizations) =>
          UserNameTile(),
      order: 0,
      sizeX: 5,
      sizeY: 1,
      type: DashboardTiles.NAME
  ),
  TileData(
      tileBuilder: (BuildContext context, TileData tile, AppLocalizations _localizations) =>
          SimpleTile(
            // text: _localizations!.getText().settingsSettingsTitle(),
            key: Key('tile_more_settings'),
            icon: Icons.settings,
            goTo: MoreScreenDestination(),
          ),
      order: 0,
      sizeX: 1,
      sizeY: 1,
      type: DashboardTiles.SETTINGS_BUTTON
  ),
  TileData(
      tileBuilder: (BuildContext context, TileData tile, AppLocalizations _localizations) {
        final nearestMeetingBloc = Provider.of<NearestMeetingTileBloc>(context);
        return NearestMeetingTile(nearestMeetingBloc);
      },
      order: 0,
      sizeX: 6,
      sizeY: 2,
      type: DashboardTiles.NEAREST_MEETING
  ),
  TileData(
      tileBuilder: (BuildContext context, TileData tile, AppLocalizations _localizations) =>
          SimpleTile(
              key: Key('tile_deputies'),
              icon: Icons.person,
              text: _localizations.getText().deputiesDeputiesListTitle(),
              goTo: DeputiesListDestination()
          ),
      order: 0,
      sizeX: 2,
      sizeY: 2,
      type: DashboardTiles.DEPUTIES
  ),
  TileData(
      tileBuilder: (BuildContext context, TileData tile, AppLocalizations _localizations) =>
          SimpleTile(
            key: Key('tile_speeches'),
            icon: Icons.record_voice_over,
            text: _localizations.getText().speechesSpeechesListTitle(),
            goTo: SpeechesListDestination(),
          ),
      order: 0,
      sizeX: 2,
      sizeY: 2,
      type: DashboardTiles.SPEECHES
  ),
  TileData(
      tileBuilder: (BuildContext context, TileData tile, AppLocalizations _localizations) =>
          SimpleTile(
              key: Key('tile_votes'),
              icon: MdiIcons.vote,
              text: _localizations.getText().votingsVotingListTitle(),
              goTo: VotesListDestination()
          ),
      order: 0,
      sizeX: 2,
      sizeY: 2,
      type: DashboardTiles.VOTES
  )
];