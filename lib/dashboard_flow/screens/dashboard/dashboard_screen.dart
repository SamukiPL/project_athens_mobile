import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/presentation/base_screen.dart';
import 'package:project_athens/athens_core/presentation/grid/grid.dart';
import 'package:project_athens/athens_core/presentation/grid/tile.dart';
import 'package:project_athens/dashboard_flow/cache/dashboard_tiles_data_cache.dart';
import 'package:project_athens/dashboard_flow/screens/dashboard/dashboard_bloc.dart';
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
    final DashboardTilesDataCache dashboardTilesDataCache =
      Provider.of<DashboardTilesDataCache>(context);

    return Container(
      padding: EdgeInsets.all(8),
      child: FutureProvider<List<TileData>?>.value(
          value: bloc.getTiles(),
          initialData: null,
          child: Consumer<List<TileData>?>(
            builder: (context, tiles, _) => tiles != null
                ? RefreshIndicator(
                    onRefresh: () => dashboardTilesDataCache.forceRefresh(),
                    child: Grid(
                      gridSize: 12,
                      onTileReordered: (List<TileData> tiles) async {
                        bloc.saveTiles(tiles);
                      },
                      tiles: tiles,
                    ),
            ) : Container()
          )
      )
    );
  }

  @override
  Widget? buildFloatingActionButton(BuildContext context, DashboardBloc bloc) => null;
}