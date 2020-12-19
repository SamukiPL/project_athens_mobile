import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/navigation/bottom_navigation_bloc.dart';
import 'package:project_athens/athens_core/navigation/destination_manager.dart';
import 'package:project_athens/athens_core/presentation/base_screen.dart';
import 'package:project_athens/athens_core/presentation/search_app_bar/search_app_bar.dart';
import 'package:project_athens/deputies_flow/navigation/deputies_destinations.dart';
import 'package:project_athens/deputies_flow/screens/list/deputies_list_bloc.dart';
import 'package:project_athens/deputies_flow/screens/list/list_impl/deputies_list.dart';
import 'package:project_athens/deputies_utils/domain/deputy_model.dart';
import 'package:provider/provider.dart';

class DeputiesListScreen extends BaseScreen<DeputiesListBloc> {

  final BottomNavItem _currentBottomBarItem;

  DeputiesListScreen(this._currentBottomBarItem);

  @override
  BottomNavItem get currentBottomBarItem => _currentBottomBarItem;

  @override
  bool get showBackArrow => currentBottomBarItem != BottomNavItem.DEPUTIES;

  @override
  String getAppBarTitle(AppLocalizations localizations, DeputiesListBloc bloc) {
    return localizations.getText().deputiesDeputiesListTitle();
  }

  @override
  Widget buildBody(BuildContext context, DeputiesListBloc bloc) {
     final destinationManager = Provider.of<DestinationManager>(context);
    return StreamProvider<DeputyModel>.value(
      value: bloc.goToDetails,
      updateShouldNotify: (_, model) => goToDetails(context, model, destinationManager),
      child: Consumer<DeputyModel>(
        builder: (BuildContext context, DeputyModel value, Widget child) => child,
        child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Container(
                  height: 0,
                  child: DeputiesList(bloc.adapter),
                ),
              )
            ]
        ),
      ),
    );
  }

  @override
  Widget buildFloatingActionButton(BuildContext context, DeputiesListBloc bloc) => null;

  @override
  Widget buildAppBar(BuildContext context, DeputiesListBloc bloc) {
    final AppLocalizations localizations = Provider.of<AppLocalizations>(context);

    return SearchAppBar(title: getAppBarTitle(localizations, bloc), hintText: "Deputies", searchQuery: (query) {}, showBackArrow: showBackArrow);
  }

  bool goToDetails(BuildContext context, DeputyModel model, DestinationManager destinationManager) {
    destinationManager.goToDestination(context, DeputyDetailsDestination(model, currentBottomBarItem));
    return false;
  }

}