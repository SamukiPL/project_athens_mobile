import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/presentation/grid/tile.dart';
import 'package:reorderableitemsview/reorderableitemsview.dart';

class Grid extends StatefulWidget {
  final List<TileData> tiles;
  final int gridSize;
  void Function(List<TileData> tiles)? onTileReordered;

  Grid({required this.tiles, this.gridSize = 3, this.onTileReordered});

  @override
  GridState createState() => GridState(tiles: tiles, gridSize: gridSize, onTileReordered: onTileReordered);
}

class GridState extends State<Grid> {

  final List<TileData> tiles;
  final int gridSize;
  void Function(List<TileData> tiles)? onTileReordered;

  GridState({required this.tiles, this.gridSize = 3, this.onTileReordered}) : super();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final sidePadding = 8.0;
    final oneTileWidth = width / this.gridSize - 2 * sidePadding;
    final localizations = AppLocalizations.of(context);

    return Container(
      width: double.infinity,
      child: ReorderableItemsView(
        crossAxisCount: gridSize,
        children: tiles.map((e) => e.tileBuilder(context, e, localizations!)).toList(),
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            tiles.insert(newIndex, tiles.removeAt(oldIndex));

            if (onTileReordered != null) {
              onTileReordered!(tiles);
            }
          });
        },

        isGrid: true,
        staggeredTiles: tiles.map((e) => StaggeredTileExtended.count(e.sizeX.toInt(), e.sizeY.toInt())).toList(),
      )
      // StaggeredGridView.countBuilder(
      //   itemBuilder: (BuildContext context, int index) =>
      //       Container(
      //         width: oneTileWidth * tiles[index].sizeX,
      //         height: oneTileWidth * tiles[index].sizeY,
      //         child: tiles[index].tileBuilder(context, tiles[index]),
      //       ),
      //   crossAxisCount: gridSize,
      //   itemCount: tiles.length,
      //   padding: EdgeInsets.all(sidePadding),
      //   staggeredTileBuilder: (int index) {
      //     final tile = tiles[index];
      //
      //     return StaggeredTile.count(
      //       tile.sizeX, tile.sizeY
      //     );
      //   },
      //   // mainAxisSpacing: 4.0,
      //   // crossAxisSpacing: 4.0,
      // ),

    );
  }
}