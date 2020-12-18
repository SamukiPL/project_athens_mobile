import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/athens_core/injections/module_widget.dart';
import 'package:project_athens/athens_core/navigation/bottom_navigation_bloc.dart';
import 'package:project_athens/athens_core/navigation/bottom_navigation_widget.dart';
import 'package:project_athens/athens_core/navigation/destination_manager.dart';
import 'package:project_athens/athens_core/presentation/base_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class BaseScreen<BLOC extends BaseBloc> extends StatelessWidget {

  BottomNavItem get currentBottomBarItem;

  bool get showBackArrow => true;

  @override
  Widget build(BuildContext context) {
    return Consumer<BLOC>(
      builder: (context, bloc, _) => StreamProvider<ScreenState>.value(
        value: bloc.state,
        updateShouldNotify: (_, current) {
          stateListener(context, bloc, current);
          return false;
        },
        child: Consumer<ScreenState>(
          builder: (context, _, child) => child,
          child: Scaffold(
            appBar: buildAppBar(context, bloc),
            body: buildBody(context, bloc),
            floatingActionButton: buildFloatingActionButton(context, bloc),
            bottomNavigationBar: BottomNavigationWidget(currentItem: currentBottomBarItem),
          ),
        ),
      ),
    );
  }

  void stateListener(BuildContext context, BLOC bloc, ScreenState state) {
    switch (state) {
      case ScreenState.SUCCESS:
        onSuccess(context);
        break;
      case ScreenState.AUTH_FAILURE:
        onAuthFailure();
        break;
      case ScreenState.NETWORK_FAILURE:
        onNetworkFailure(bloc);
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
              destinationManager.goBack();
              Navigator.pop(context);
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