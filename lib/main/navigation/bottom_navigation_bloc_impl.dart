import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/navigation/bottom_navigation_bloc.dart';
import 'package:project_athens/athens_core/navigation/destination_manager.dart';
import 'package:project_athens/deputies_flow/navigation/deputies_destinations.dart';
import 'package:project_athens/settings_flow/navigation/settings_destinations.dart';
import 'package:project_athens/speeches_flow/navigation/speeches_destinations.dart';
import 'package:project_athens/timeline_flow/navigation/timeline_destinations.dart';
import 'package:project_athens/voting_flow/navigation/voting_destinations.dart';

class BottomNavigationBlocImpl extends BottomNavigationBloc {

  BottomNavItem _currentItem = BottomNavItem.TIMELINE;

  @override
  BottomNavItem get currentItem => _currentItem;

  DestinationManager _currentDestinationManager;

  List<DestinationManager> destinationManagers = BottomNavItem.values.map((item) => item.getDestinationManager()).toList();

  BottomNavigationBlocImpl() {
    _currentDestinationManager = destinationManagers.first;
  }

  @override
  void pickItem(int i) {
    final newItem = BottomNavItem.values[i];
    destinationManagers[i] = newItem.getDestinationManager();
    _currentItem = newItem;
    _currentDestinationManager = destinationManagers[i];
  }

  DestinationManager getDestinationManager(BuildContext context) {
    return _currentDestinationManager;
  }

}