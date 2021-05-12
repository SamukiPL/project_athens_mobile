import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/navigation/bottom_navigation_widget.dart';
import 'package:project_athens/athens_core/navigation/destination_manager.dart';
import 'package:project_athens/athens_core/presentation/base_blocs/base_bloc.dart';
import 'package:project_athens/athens_core/presentation/delegates/redirection_delegate.dart';
import 'package:project_athens/athens_core/presentation/widget_state.dart';
import 'package:provider/provider.dart';

abstract class BaseScreen<BLOC extends BaseBloc> extends StatelessWidget with RedirectionDelegate {

  bool get showBackArrow => true;

  @override
  Widget build(BuildContext context) {
    return Consumer<BLOC>(
      builder: (context, bloc, _) => StreamProvider<WidgetState>.value(
        value: bloc.state,
        updateShouldNotify: (_, current) {
          stateListener(context, bloc, current);
          return false;
        },
        child: Consumer<WidgetState>(
          builder: (context, _, child) => child,
          child: Scaffold(
            appBar: buildAppBar(context, bloc),
            body: buildBody(context, bloc),
            floatingActionButton: buildFloatingActionButton(context, bloc),
            bottomNavigationBar: BottomNavigationWidget(),
          ),
        ),
      ),
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
        onNetworkFailure(bloc);
        break;
      case Redirection:
        Redirection redirection = state;
        goToDestination(context, redirection.destination);
        break;
    }
  }

  @protected
  Widget buildBody(BuildContext context, BLOC bloc);

  @protected
  Widget buildAppBar(BuildContext context, BLOC bloc) {
    final AppLocalizations localizations = Provider.of<AppLocalizations>(context);

    return AppBar(
      leading: showBackArrow
        ? Consumer<DestinationManager>(
            builder: (context, destinationManager, _) => BackButton(
            color: Colors.white,
            onPressed: () {
              destinationManager.goBack(context);
            },
          )
        )
        : null,
      title: Text(
        getAppBarTitle(localizations, bloc),
        style: TextStyle(
          color: Colors.white
        ),
      ),
    );
  }

  @protected
  String getAppBarTitle(AppLocalizations localizations, BLOC bloc) {
    throw UnimplementedError('getAppBarTitle has to be overridden');
  }

  @protected
  Widget buildFloatingActionButton(BuildContext context, BLOC bloc);

  @protected
  void onSuccess(BuildContext context) {}

  @protected
  void onNetworkFailure(BLOC bloc) {}

  @protected
  void onAuthFailure() {}

}