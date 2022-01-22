import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/presentation/grid/tiles/simple_tile/simple_tile.dart';
import 'package:project_athens/dashboard_flow/screens/dashboard/tiles/dashboard_tiles.dart';

class TileData {
  final SimpleTile Function(BuildContext, TileData, AppLocalizations localizations) tileBuilder;
  int order;
  final int sizeX;
  final double sizeY;
  final DashboardTiles type;

  TileData({
    required this.tileBuilder,
    required this.order,
    required this.sizeX,
    required this.sizeY,
    required this.type
  });
}
