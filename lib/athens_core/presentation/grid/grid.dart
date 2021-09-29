import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:project_athens/athens_core/presentation/grid/tile.dart';

class Grid extends StatelessWidget {

  final List<TileData> tiles;
  final int gridSize;

  Grid({required this.tiles, this.gridSize = 3});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final sidePadding = 8.0;
    final oneTileWidth = width / this.gridSize - 2 * sidePadding;

    return Container(
      width: double.infinity,
      child: StaggeredGridView.countBuilder(
        itemBuilder: (BuildContext context, int index) =>
            Container(
              width: oneTileWidth * tiles[index].sizeX,
              height: oneTileWidth * tiles[index].sizeY,
              child: tiles[index].tileBuilder(context, tiles[index]),
            ),
        crossAxisCount: gridSize,
        itemCount: tiles.length,
        padding: EdgeInsets.all(sidePadding),
        staggeredTileBuilder: (int index) {
          final tile = tiles[index];

          return StaggeredTile.count(
            tile.sizeX, tile.sizeY
          );
        },
        // mainAxisSpacing: 4.0,
        // crossAxisSpacing: 4.0,
      ),

    );
  }
}