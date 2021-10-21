import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/navigation/destination_manager.dart';
import 'package:project_athens/athens_core/presentation/delegates/redirection_delegate.dart';
import 'package:project_athens/athens_core/presentation/grid/tiles/tile_base.dart';

class SimpleTile extends TileBase with RedirectionDelegate {
  final String? text;
  final IconData? icon;
  final BoxDecoration? boxDecoration;
  final TextStyle? textStyle;
  final Destination? goTo;
  final double? elevation;

  SimpleTile({
    this.text,
    this.icon,
    this.boxDecoration,
    this.textStyle,
    this.goTo,
    this.elevation = 2,
    Key? key
  }) : super(key: key);
  //     : assert(
  //   text != null || icon != null
  // );

  factory SimpleTile.plain() {
    return SimpleTile(text: "");
  }

  @override
  Widget build(BuildContext context) {
    return buildTile(
        context: context,
        boxDecoration: boxDecoration,
        tile: buildTextAndIcon(text: text, icon: icon),
        goTo: goTo
    );
  }

  @protected
  Widget buildTile({required BuildContext context, required Widget tile, BoxDecoration? boxDecoration, Destination? goTo}) {
    final theme = Theme.of(context);

    final BoxDecoration decoration = boxDecoration != null
        ? boxDecoration
        : BoxDecoration(
        // borderRadius: BorderRadius.all(Radius.circular(8)),
        // color: Colors.white70,
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.3),
        //     spreadRadius: 1,
        //     blurRadius: 2,
        //     offset: Offset(0, 0), // changes position of shadow
        //   ),
        // ],
        // border: Border.all(color: Colors.black, width: 1)
    );

    if (goTo != null) {
      tile = InkWell(
        onTap: () => goToDestination(context, goTo),
        child: tile,
      );
    }

    return Container(
        width: double.infinity,
        margin: EdgeInsets.all(4),
        decoration: decoration,
        // child: Card(
        //   elevation: elevation,
        //   child: tile,
        //
        // ),
        child: Material(
          child: tile,
          elevation: elevation?.toDouble() ?? 0.0,
          shadowColor: theme.primaryColor.withOpacity(0.4),
          color: Colors.white,
          borderOnForeground: true,

        ),
      // child: tile
    );
  }

  @protected
  Widget buildTextAndIcon({
    String? text,
    IconData? icon,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center
  }) {
    final List<Widget> widgetsToRender = List.empty(growable: true);

    if (icon != null) {
      final iconWidget = Icon(icon, color: Colors.black.withOpacity(0.6),);
      widgetsToRender.add(iconWidget);
    }

    if (text != null) {
      final TextStyle style = textStyle != null
          ? textStyle!
          : TextStyle(
          color: Colors.black87
      );

      final textWidget = Text(
        text,
        style: style,
      );
      widgetsToRender.add(textWidget);
    }

    return Container(
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        mainAxisAlignment: mainAxisAlignment,
        children: widgetsToRender,
      ),
    );
  }

  @protected
  Widget buildLoader() {
    return Container(
      width: double.infinity,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}