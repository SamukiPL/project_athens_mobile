import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/presentation/base_screen.dart';
import 'package:project_athens/athens_core/presentation/button_loader/button_loader.dart';
import 'package:project_athens/athens_core/presentation/grid/grid.dart';
import 'package:project_athens/athens_core/presentation/grid/tile.dart';
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
    return Container(
        padding: EdgeInsets.all(8),
        child: FutureProvider<List<TileData>?>.value(
            value: bloc.getTiles(),
            initialData: null,
            child: Consumer<List<TileData>?>(
                builder: (context, tiles, _) => tiles != null
                    ? RefreshIndicator(
                        onRefresh: () => bloc.forceRefresh(),
                        child: Column(
                          children: [
                            StreamProvider<bool>.value(
                              initialData: false,
                              value: bloc.dataOutdatedStream,
                              child: Consumer<bool>(
                                child:
                                    _buildNewDataAvailableInfo(context, bloc),
                                builder: (context, value, child) =>
                                    value == true ? child! : Container(),
                              ),
                            ),
                            Expanded(
                              child: Grid(
                                gridSize: 12,
                                onTileReordered: (List<TileData> tiles) async {
                                  bloc.saveTiles(tiles);
                                },
                                tiles: tiles,
                              ),
                            )
                          ],
                        ))
                    : Container())));
  }

  Widget _buildNewDataAvailableInfo(BuildContext context, DashboardBloc bloc) {
    final AppLocalizations l10n = Provider.of<AppLocalizations>(context);

    return Container(
      padding: EdgeInsets.all(4),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(l10n.getText().universalNewDataAvailable()),
        ButtonLoader(bloc.refreshDataButtonLoaderBloc,
            callback: bloc.forceRefresh,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
                side: BorderSide(
                    width: 1, color: Theme.of(context).primaryColor)),
            actionStateWidget: Container(
              child: Text(
                l10n.getText().universalRefresh(),
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ))
      ]),
    );
  }

  @override
  Widget? buildFloatingActionButton(BuildContext context, DashboardBloc bloc) =>
      null;
}
