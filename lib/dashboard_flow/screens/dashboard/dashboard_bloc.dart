import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/configuration/configuration_delegate.dart';
import 'package:project_athens/athens_core/configuration/configuration_storage_names.dart';
import 'package:project_athens/athens_core/presentation/alert_bottom_sheet/alert_bottom_sheet.dart';
import 'package:project_athens/athens_core/presentation/base_blocs/base_bloc.dart';
import 'package:project_athens/athens_core/presentation/data_loading/data_loading_bloc.dart';
import 'package:project_athens/athens_core/presentation/data_loading/data_loading_state.dart';
import 'package:project_athens/athens_core/presentation/grid/tile.dart';
import 'package:project_athens/athens_core/presentation/widget_state.dart';
import 'package:project_athens/dashboard_flow/cache/dashboard_tiles_data_cache.dart';
import 'package:project_athens/dashboard_flow/screens/dashboard/tiles/dashboard_configuration.dart';
import 'package:project_athens/dashboard_flow/screens/dashboard/tiles/dashboard_tile_storage.dart';
import 'package:project_athens/deputies_utils/cache/subscribed_deputies_cache.dart';
import 'package:rxdart/rxdart.dart';

class DashboardBloc extends BaseBloc
    with
        ConfigurationDelegate<List<DashboardTileStorage>,
            DashboardTileStorage> {
  DashboardBloc(this._subscribedDeputiesCache, this._dashboardTilesDataCache) {
    _deputiesChangeSub = _subscribedDeputiesCache
        .subscribedDeputiesChangedStream
        .listen((event) {
      _dataOutdatedSubject.add(true);
    });
  }

  final SubscribedDeputiesCache _subscribedDeputiesCache;
  final DashboardTilesDataCache _dashboardTilesDataCache;
  late StreamSubscription _deputiesChangeSub;

  @override
  String get preferenceName => ConfigurationStorageNames.DASHBOARD_TILES;

  @override
  List<DashboardTileStorage> get defaultStorageValue =>
      allTiles.map((e) => DashboardTileStorage(e.type, e.order)).toList();

  ReplaySubject<bool> _dataOutdatedSubject = ReplaySubject<bool>();
  Stream<bool> get dataOutdatedStream => _dataOutdatedSubject.stream;

  DataLoadingBloc _refreshDataButtonLoaderBloc = DataLoadingBloc();
  DataLoadingBloc get refreshDataButtonLoaderBloc =>
      _refreshDataButtonLoaderBloc;

  Future<List<TileData>> getTiles() async {
    final List<DashboardTileStorage> config = await fetchPreference(
        (Map<String, dynamic> json) => DashboardTileStorage.fromJson(json));

    return config
        .map((configTile) =>
            allTiles.firstWhere((element) => element.type == configTile.type)
              ..order = configTile.order)
        .toList();
  }

  void saveTiles(List<TileData> newTiles) async {
    final storageTiles =
        newTiles.map((e) => DashboardTileStorage(e.type, e.order)).toList();

    await updatePreference(storageTiles);
  }

  Future<void> forceRefresh(BuildContext context) {
    _refreshDataButtonLoaderBloc
        .setDataLoadingState(DataLoadingState.loading());

    return _dashboardTilesDataCache.forceRefresh().then((value) {
      _dataOutdatedSubject.add(false);
      _refreshDataButtonLoaderBloc
          .setDataLoadingState(DataLoadingState.initialLoading());

      _dataOutdatedSubject.add(false);
    }).catchError((err) {
      _refreshDataButtonLoaderBloc.setDataLoadingState(
          DataLoadingState.error((err as Exception).getErrorType()));

      showErrorBottomSheet(context,
          error: err,
          onClose: () => _refreshDataButtonLoaderBloc
              .setDataLoadingState(DataLoadingState.initialLoading()));
    });
  }

  @override
  void dispose() {
    super.dispose();

    _dataOutdatedSubject.close();
    _deputiesChangeSub.cancel();
  }
}
