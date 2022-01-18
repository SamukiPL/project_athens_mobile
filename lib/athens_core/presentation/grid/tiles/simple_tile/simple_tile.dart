import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/navigation/destination_manager.dart';
import 'package:project_athens/athens_core/presentation/data_loading/data_loading_state.dart';
import 'package:project_athens/athens_core/presentation/delegates/redirection_delegate.dart';
import 'package:project_athens/athens_core/presentation/grid/tiles/simple_tile/simple_tile_bloc.dart';
import 'package:project_athens/athens_core/presentation/grid/tiles/tile_base.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class SimpleTile extends TileBase with RedirectionDelegate {
  final String? text;
  final IconData? icon;
  final BoxDecoration? boxDecoration;
  final TextStyle? textStyle;
  final Destination? goTo;
  final Destination Function()? goToFn;
  final double? elevation;
  final SimpleTileBloc bloc;

  final BehaviorSubject<bool> showLoaderStream = BehaviorSubject<bool>.seeded(false);

  static final Color iconColor = Colors.black.withOpacity(0.6);

  SimpleTile({
    this.text,
    this.icon,
    this.boxDecoration,
    this.textStyle,
    this.goTo,
    this.goToFn,
    this.elevation = 4,
    required this.bloc,
    Key? key
  }) : super(key: key);

  factory SimpleTile.plain() {
    return SimpleTile(text: "", bloc: SimpleTileBloc());
  }

  @override
  Widget build(BuildContext context) {
    return buildTile(
        context: context,
        boxDecoration: boxDecoration,
        tile: buildTextAndIcon(text: text, icon: icon),
        goTo: goTo,
        goToFn: goToFn,
    );
  }

  @protected
  Widget buildTile({required BuildContext context, required Widget tile, BoxDecoration? boxDecoration, Destination? goTo, Destination Function()? goToFn}) {
    final BoxDecoration decoration = boxDecoration != null
        ? boxDecoration
        : BoxDecoration();

    if (goTo != null) {
      tile = InkWell(
        onTap: () => goToDestination(context, goTo),
        child: tile,
      );
    }

    if (goToFn != null) {
      tile = InkWell(
        onTap: () => goToDestination(context, goToFn()),
        child: tile
      );
    }

    return Stack(
      children: [
        Container(
          width: double.infinity,
          margin: EdgeInsets.all(4),
          decoration: decoration,
          child: Material(
            child: Container(
              child: tile,
              decoration: elevation != null && elevation != 0 ? BoxDecoration(
                  border: Border.all(color: Colors.black.withOpacity(0.05), )
              ) : BoxDecoration(),
            ),
            elevation: elevation?.toDouble() ?? 0.0,
            shadowColor: Colors.black.withOpacity(0.3),
            color: Colors.white,
            borderOnForeground: true,
            type: MaterialType.card,
          ),
        ),
        StreamProvider<DataLoadingState>.value(
          value: bloc.loadingState,
          initialData: DataLoadingState.initialLoading(),
          child: Consumer<DataLoadingState>(
            builder: (context, state, _) => Visibility(
                child: buildLoader(),
                visible: state is InitialLoading
            ),
          ),
        )
      ],
    );

    //   Container(
    //     width: double.infinity,
    //     margin: EdgeInsets.all(4),
    //     decoration: decoration,
    //     child: Material(
    //       child: Container(
    //         child: tile,
    //         decoration: elevation != null && elevation != 0 ? BoxDecoration(
    //           border: Border.all(color: Colors.black.withOpacity(0.05), )
    //         ) : BoxDecoration(),
    //       ),
    //       elevation: elevation?.toDouble() ?? 0.0,
    //       shadowColor: Colors.black.withOpacity(0.3),
    //       color: Colors.white,
    //       borderOnForeground: true,
    //       type: MaterialType.card,
    //     ),
    // );
  }

  @protected
  Widget buildTextAndIcon({
    String? text,
    IconData? icon,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
  }) {
    final List<Widget> widgetsToRender = List.empty(growable: true);

    if (icon != null) {
      final iconWidget = Icon(icon, color: SimpleTile.iconColor,);
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

  void dispose() {
    showLoaderStream.close();
  }
}