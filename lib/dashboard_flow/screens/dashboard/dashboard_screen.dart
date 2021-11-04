import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/presentation/base_screen.dart';
import 'package:project_athens/athens_core/presentation/grid/grid.dart';
import 'package:project_athens/athens_core/presentation/grid/tile.dart';
import 'package:project_athens/athens_core/presentation/grid/tiles/simple_tile/simple_tile.dart';
import 'package:project_athens/dashboard_flow/screens/dashboard/dashboard_bloc.dart';
import 'package:project_athens/dashboard_flow/screens/dashboard/tiles/dashboard_configuration.dart';
import 'package:project_athens/dashboard_flow/screens/dashboard/tiles/dashboard_tiles.dart';
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
    final Future<List<TileData>?> getTilesFuture = bloc.getTiles();

    return Container(
      padding: EdgeInsets.all(8),
      child: FutureProvider<List<TileData>?>.value(
          value: getTilesFuture,
          initialData: null,
          child: Consumer<List<TileData>?>(
            builder: (context, tiles, _) => tiles != null
                ? Grid(
                  gridSize: 12,
                  onTileReordered: (List<TileData> tiles) async {
                    bloc.saveTiles(tiles);
                  },
                  tiles: allTiles,
                )
              : Container()
          )
      )
      // child: Grid(
      //   gridSize: 6,
      //   onTileReordered: (List<TileData> tiles) async {
      //     bloc.saveTiles(tiles);
      //   },
      //   tiles: allTiles,
      // )
    );
  }

  @override
  Widget? buildFloatingActionButton(BuildContext context, DashboardBloc bloc) => null;
}