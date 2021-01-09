import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/athens_core/injections/module_widget.dart';
import 'package:project_athens/athens_core/presentation/base_blocs/base_bloc.dart';
import 'package:project_athens/athens_core/presentation/widget_state.dart';
import 'package:provider/provider.dart';

abstract class BaseLoginScreen<BLOC extends BaseBloc> extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ModuleWidget(
        providers: getProviders(context),
        child: Consumer<BLOC>(
          builder: (context, bloc, _) {
            return StreamProvider<WidgetState>.value(
              value: bloc.state,
              updateShouldNotify: (_, current) {
                stateListener(context, bloc, current);
                return false;
              },
              child: Consumer<WidgetState>(
                builder: (context, _, child) => child,
                child: Scaffold(
                  appBar: generateAppBar(context, bloc),
                  body: Builder(builder: (context) => bodyBuilder(context, bloc)),
                  floatingActionButton: generateFab(context, bloc),
                ),
              ),
            );
          },
        ));
  }

  List<Module> getProviders(BuildContext context);

  @protected
  Widget bodyBuilder(BuildContext context, BLOC bloc) {
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        padding: EdgeInsets.all(0),
          child: ConstrainedBox(
              constraints:
                  BoxConstraints(minHeight: constraints.maxHeight),
              child: generateBody(context, bloc))),
    );
  }

  void stateListener(BuildContext context, BLOC bloc, WidgetState state) {
      switch (state.runtimeType) {
        case SuccessState:
          onSuccess(context);
          break;
        case AuthFailure:
          onAuthFailure();
          break;
        case ErrorState:
          showModalBottomSheet(context: context, builder: (context) => Column(
            children: <Widget>[
              Text("No internet connection"),
              RaisedButton(
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    "Try again",
                    style: TextStyle(color: Colors.white),
                    textScaleFactor: 1.5,
                  ),
                ),
                onPressed: () => onNetworkFailure(bloc),
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
              )
            ],
          ));
          break;
      }
  }

  Widget generateAppBar(BuildContext context, BLOC bloc);

  Widget generateBody(BuildContext context, BLOC bloc);

  Widget generateFab(BuildContext context, BLOC bloc);

  void onSuccess(BuildContext context);

  void onNetworkFailure(BLOC bloc);

  void onAuthFailure();
}
