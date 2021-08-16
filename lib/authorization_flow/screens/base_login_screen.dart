import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
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
              initialData: WidgetState.empty(),
              value: bloc.state,
              updateShouldNotify: (_, current) {
                stateListener(context, bloc, current);
                return false;
              },
              child: Consumer<WidgetState>(
                builder: (context, _, child) => child!,
                child: Scaffold(
                  appBar: generateAppBar(context, bloc) as PreferredSizeWidget?,
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
    final localizations = Provider.of<AppLocalizations>(context);

      switch (state.runtimeType) {
        case SuccessState:
          onSuccess(context);
          break;
        case AuthFailure:
          onAuthFailure(context, bloc);
          break;
        case ErrorState:
          String errMsg = _getErrorMessage(state as ErrorState, localizations);
          showModalBottomSheet(context: context, builder: (context) =>
              Container(
                padding: EdgeInsets.all(12),
                child:Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(bottom: 8),
                      child: Icon(Icons.sentiment_dissatisfied, size: 75),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 8),
                      child: Text(
                        errMsg,
                        // localizations.getText().universalErrorNetwork(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20
                        ),
                      ),
                    ),
                    Expanded(child: Container(),),

                    RaisedButton(
                      child: Container(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          localizations.getText().universalRetry(),
                          style: TextStyle(color: Colors.white),
                          textScaleFactor: 1.5,
                        ),
                      ),
                      onPressed: ((){
                        Navigator.pop(context);
                        onNetworkFailure(bloc);
                      }),
                      color: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    )
                  ],
                )
              ),
            );
          break;
      }
  }

  _getErrorMessage(ErrorState state, AppLocalizations localizations) {
    final errType = state.type;
    switch(errType) {
      case ErrorType.NETWORK:
        return localizations.getText().universalErrorNetwork();
        break;
      case ErrorType.SERVER:
        return localizations.getText().universalErrorServer();
        break;
      case ErrorType.UNKNOWN:
        return localizations.getText().universalErrorUnknown();
        break;
    }
  }

  Widget? generateAppBar(BuildContext context, BLOC bloc);

  Widget generateBody(BuildContext context, BLOC bloc);

  Widget? generateFab(BuildContext context, BLOC bloc);

  void onSuccess(BuildContext context);

  void onNetworkFailure(BLOC bloc);

  void onAuthFailure(BuildContext context, BLOC bloc);
}
