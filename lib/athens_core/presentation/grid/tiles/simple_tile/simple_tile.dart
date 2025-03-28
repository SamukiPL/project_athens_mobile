import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/navigation/destination_manager.dart';
import 'package:project_athens/athens_core/presentation/data_loading/data_loading_state.dart';
import 'package:project_athens/athens_core/presentation/delegates/redirection_delegate.dart';
import 'package:project_athens/athens_core/presentation/grid/tiles/simple_tile/simple_tile_bloc.dart';
import 'package:provider/provider.dart';

class SimpleTile extends StatelessWidget with RedirectionDelegate {
  final String? text;
  final IconData? icon;
  final BoxDecoration boxDecoration;
  final TextStyle? textStyle;
  final Destination? goTo;
  final Destination Function()? goToFn;
  final double? elevation;
  final SimpleTileBloc bloc;

  static final Color iconColor = Colors.black.withOpacity(0.6);

  SimpleTile({
    this.text= "",
    this.icon,
    this.boxDecoration = const BoxDecoration(),
    this.textStyle = const TextStyle(
        color: Colors.black87
    ),
    this.goTo,
    this.goToFn,
    this.elevation = 4,
    required this.bloc,
    Key? key
  }) : super(key: key);

  @protected
  Widget build(BuildContext context) {
    return buildTile(
        context: context,
        tile: buildTileContent(context),
    );
  }
  
  @protected
  Widget buildTileContent(BuildContext context) {
    return buildTextAndIcon(text: text, icon: icon);
  }

  @protected
  Widget buildTile({required BuildContext context, required Widget tile}) {
    final BoxDecoration decoration = boxDecoration;

    final Widget childTile = goTo != null || goToFn != null
        ? InkWell(
          onTap: () => goToDestination(context, goTo ?? goToFn!()),
          child: tile,
        ) : tile;

    return Stack(
      children: [
        Container(
          width: double.infinity,
          margin: EdgeInsets.all(4),
          decoration: decoration,
          child: Material(
            child: Container(
              child: childTile,
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
      final textWidget = Text(
        text,
        style: textStyle,
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
  }
}
