import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/presentation/backdrop/backdrop_bloc.dart';
import 'package:provider/provider.dart';

class BackdropWidget extends StatelessWidget {

  final Widget bottomChild;
  final Widget topChild;

  final GlobalKey _cloudKey = GlobalKey();

  BackdropWidget(
      {Key? key, required this.bottomChild, required this.topChild})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BackdropBloc>(
      create: (_) => BackdropBloc(),
      builder: (context, _) => Stack(
        fit: StackFit.loose,
        children: [
          buildBottomChild(context),
          buildIcon(context),
          buildTopChild(context)
        ],
      ),
    );
  }

  Widget buildBottomChild(BuildContext context) {
    return Container(
      key: _cloudKey,
      color: Theme.of(context).primaryColor,
      child: bottomChild,
    );
  }

  Widget buildIcon(BuildContext context) {
    return Consumer<BackdropBloc>(
      builder: (context, bloc, _) => Container(
        alignment: Alignment.topLeft,
        margin: EdgeInsets.only(top: 4, left: 4),
        child: GestureDetector(
          onTap: () {
            bloc.changeState(_cloudKey.currentContext?.size?.height);
          },
          child: Icon(
            bloc.isBottomShowing ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }

  Widget buildTopChild(BuildContext context) {
    return Consumer<BackdropBloc>(
      child: Container(
        margin: EdgeInsets.only(top: 7),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            color: Theme
                .of(context)
                .backgroundColor,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(80))
        ),
        child: Container(child: topChild),
      ),
      builder: (context, bloc, child) =>
          GestureDetector(
            onTap: bloc.isBottomShowing ? () {
              bloc.closeBackdrop();
            } : null,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 133),
              transform: Matrix4.translationValues(
                  0, bloc.isBottomShowing ? bloc.bottomChildSize : 0, 0),
              child: child,
            ),
          ),
    );
  }

}