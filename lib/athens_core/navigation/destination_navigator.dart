import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/injections/module_widget.dart';
import 'package:project_athens/athens_core/navigation/bottom_navigation_bloc.dart';
import 'package:project_athens/athens_core/navigation/destination_manager.dart';
import 'package:project_athens/athens_core/navigation/destination_widget.dart';
import 'package:provider/provider.dart';

class DestinationNavigator extends StatelessWidget {
  final BottomNavItem bottomNavItem;

  final DestinationManager destinationManager;

  DestinationNavigator._(this.bottomNavItem, this.destinationManager);

  factory DestinationNavigator(
      BottomNavItem bottomNavItem, Destination initialDestination) {
    final manager = DestinationManager(initialDestination, bottomNavItem);
    return DestinationNavigator._(bottomNavItem, manager);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavigationBloc>(
      builder: (context, bloc, child) {
        if (bloc.wasItemReselected(bottomNavItem))
          destinationManager.popToFirst(context);
        return Offstage(
          offstage: bloc.currentItem != bottomNavItem,
          child: child,
        );
      },
      child: Provider<DestinationManager>.value(
        value: destinationManager,
        child: Navigator(
          key: GlobalKey<NavigatorState>(),
          onGenerateRoute: (_) => MaterialPageRoute(
              builder: (context) => DestinationWidget(
                destinationManager: destinationManager,
                moduleWidget: ModuleWidget(
                    providers: destinationManager.getScreenModules(context),
                    child: destinationManager.currentScreen()),
              )),
        ),
      ),
    );
  }
}
