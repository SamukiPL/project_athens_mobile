import 'package:athens_core/presentation/fab/fab_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseFab extends StatelessWidget {
  final VoidCallback onPressed;

  final FabBloc bloc;

  final Widget child;

  const BaseFab(
      {Key key, @required this.onPressed, @required this.bloc, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: bloc,
      child: Consumer<FabBloc>(
        builder: (context, bloc, _) => Visibility(
          visible: bloc.visible,
          child: FloatingActionButton(
            onPressed: onPressed,
            child: child,
          ),
        ),
      ),
    );
  }
}
