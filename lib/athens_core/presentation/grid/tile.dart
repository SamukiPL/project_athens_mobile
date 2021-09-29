import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/presentation/grid/tiles/tile_base.dart';

class TileData {
  final TileBase Function(BuildContext, TileData) tileBuilder;
  final int order;
  final int sizeX;
  final double sizeY;

  TileData({
    required this.tileBuilder,
    required this.order,
    required this.sizeX,
    required this.sizeY
  });
}