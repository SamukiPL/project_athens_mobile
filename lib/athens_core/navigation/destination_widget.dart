import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/injections/module_widget.dart';
import 'package:project_athens/athens_core/navigation/bottom_navigation_bloc.dart';
import 'package:project_athens/athens_core/navigation/destination_manager.dart';
import 'package:project_athens/athens_core/navigation/navigation_event.dart';
import 'package:provider/provider.dart';

class DestinationWidget extends StatelessWidget {
  final DestinationManager destinationManager;

  final ModuleWidget moduleWidget;

  const DestinationWidget(
      {Key key, @required this.destinationManager, @required this.moduleWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bottomNavigationBloc = Provider.of<BottomNavigationBloc>(context);
    return StreamProvider<NavigationEvent>.value(
      value: bottomNavigationBloc.destination,
      updateShouldNotify: (_, newEvent) {
        if (bottomNavigationBloc.currentItem ==
            destinationManager.bottomNavItem)
          _manageDestination(context, bottomNavigationBloc, newEvent);
        return false;
      },
      child: Consumer<NavigationEvent>(
        builder: (context, _, child) => child,
        child: moduleWidget,
      ),
    );
  }

  void _manageDestination(
      BuildContext context, BottomNavigationBloc bloc, NavigationEvent event) {
    if (event is GoToEvent) {
      _manageGoToEvent(context, bloc, event);
    } else if (event is PopEvent &&
        event.currentNavItem == destinationManager.bottomNavItem) {
      Navigator.maybePop(context);
    }
  }

  void _manageGoToEvent(
      BuildContext context, BottomNavigationBloc bloc, GoToEvent event) {
    final destination = event.destination;
    destinationManager.goToDestination(context, destination);
  }
}
