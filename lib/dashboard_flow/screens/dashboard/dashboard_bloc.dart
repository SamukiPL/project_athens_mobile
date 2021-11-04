import 'dart:convert';

import 'package:project_athens/athens_core/configuration/configuration_delegate.dart';
import 'package:project_athens/athens_core/configuration/configuration_storage_names.dart';
import 'package:project_athens/athens_core/presentation/base_blocs/base_bloc.dart';
import 'package:project_athens/athens_core/presentation/grid/tile.dart';
import 'package:project_athens/dashboard_flow/screens/dashboard/tiles/dashboard_configuration.dart';
import 'package:project_athens/dashboard_flow/screens/dashboard/tiles/dashboard_tile_storage.dart';

class DashboardBloc extends BaseBloc with ConfigurationDelegate<List<DashboardTileStorage>, DashboardTileStorage> {
  DashboardBloc();

  @override
  String get preferenceName => ConfigurationStorageNames.DASHBOARD_TILES;

  @override
  List<DashboardTileStorage> get defaultStorageValue => allTiles.map((e) => DashboardTileStorage(e.type, e.order)).toList();

  final List<TileData> TILES = allTiles;

  Future<List<TileData>> getTiles() async {
    // final List<DashboardTileStorage> config = await fetchPreference((Map<String, dynamic> json) => DashboardTileStorage.fromJson(json));
    // final List<DashboardTileStorage> config = allTiles.map((e) => DashboardTileStorage(e.type, e.order)).toList();
    //
    // final List<TileData> result = List.empty(growable: true);
    // for (final configTile in config) {
    //     final tileDef = allTiles.firstWhere((element) => element.type == configTile.type);
    //     tileDef.order = configTile.order;
    //
    //     result.add(tileDef);
    // }
    //
    // return result;
    return allTiles;
  }

  void saveTiles(List<TileData> newTiles) async {
    final storageTiles = newTiles.map((e) => DashboardTileStorage(e.type, e.order)).toList();

    await updatePreference(storageTiles);
  }
}