import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/presentation/backdrop/backdrop_bloc.dart';
import 'package:provider/provider.dart';

class BackdropWidget extends StatelessWidget {

  final Widget bottomChild;
  final Widget topChild;

  const BackdropWidget({Key key, @required this.bottomChild, @required this.topChild}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BackdropBloc>(
      create: (_) => BackdropBloc(),
      child: Consumer<BackdropBloc>(
        builder: (context, bloc, _) => Stack(
          fit: StackFit.expand,
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                bloc.setBottomChildSize(constraints.maxHeight);
                return Container(
                  color: Theme.of(context).primaryColor,
                  child: bottomChild,
                );
              },
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(top: 4, left: 4),
              child: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white,
                size: 30,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 7),
              transform: Matrix4.translationValues(0, 0, 0),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(80))
              ),
              child: Container(child: topChild),
            ),
          ],
        ),
      ),
    );
  }

}