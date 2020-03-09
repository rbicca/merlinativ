
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class StaggeredGridViewPage extends StatelessWidget {

  final List<StaggeredTile> tiles;
  final List<Widget> items;
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;

  const StaggeredGridViewPage.count({
    @required this.crossAxisCount,
    @required this.tiles,
    @required this.items,
    this.mainAxisSpacing: 16.0,
    this.crossAxisSpacing: 6.0,
  });

  static const EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 4.0);

  @override
  Widget build(BuildContext context) {

    return StaggeredGridView.countBuilder(
          crossAxisCount: crossAxisCount,
          itemCount: tiles.length,
          itemBuilder: (ctx,i) => items[i],
          mainAxisSpacing: mainAxisSpacing,
          crossAxisSpacing: crossAxisSpacing,
          padding: padding,
          staggeredTileBuilder: _getStaggeredTile,
        );
    }

  StaggeredTile _getStaggeredTile(int i) {
    return i >= tiles.length ? null : tiles[i];
  }

}
