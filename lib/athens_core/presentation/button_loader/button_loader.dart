import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/presentation/data_loading/data_loading_bloc.dart';
import 'package:project_athens/athens_core/presentation/data_loading/data_loading_state.dart';
import 'package:provider/provider.dart';

class ButtonLoader extends StatelessWidget {
  final DataLoadingBloc _bloc;

  final Widget actionStateWidget;
  final void Function() callback;
  final Color? buttonBg;
  final RoundedRectangleBorder? shape;
  final EdgeInsetsGeometry? mainPadding;

  const ButtonLoader(this._bloc, {
    required this.actionStateWidget,
    required this.callback,
    this.buttonBg,
    this.shape,
    this.mainPadding
  });

  @override build(BuildContext context) {
    return ElevatedButton(
      child: ChangeNotifierProvider<DataLoadingBloc>.value(
          value: _bloc,
          child: Consumer<DataLoadingBloc>(
            builder: (context, bloc, _) => AnimatedSize(
                duration: Duration(milliseconds: 250),
                curve: Curves.easeOut,
                child: Container(
                  padding: mainPadding,
                  child: _getChild(bloc)
                )
            ),
          )
      ),
      onPressed: callback,
      style: ElevatedButton.styleFrom(
        primary: buttonBg,
        shape: shape
      )
    );
  }

  Widget _getChild(DataLoadingBloc bloc) {
    switch(bloc.loadingState.runtimeType) {
      case InitialLoading:
      case LoadingError:
        return actionStateWidget;
      case Loading:
      case InitialLoading:
        return Container(
          height: 25,
          width: 25,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        );
      case ContentLoaded:
        return Icon(
          Icons.check,
          color: Colors.white,
        );
      default:
        throw new UnsupportedError("Unsupported state " + bloc.loadingState.runtimeType.toString());
    }
  }
}
