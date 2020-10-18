import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/navigation/bottom_navigation_bloc.dart';
import 'package:project_athens/athens_core/navigation/destination_manager.dart';
import 'package:project_athens/deputies_flow/navigation/deputies_destinations.dart';
import 'package:project_athens/settings_flow/navigation/settings_destinations.dart';
import 'package:project_athens/speeches_flow/navigation/speeches_destinations.dart';
import 'package:project_athens/timeline_flow/navigation/timeline_destinations.dart';

class BottomNavigationBlocImpl extends BottomNavigationBloc {

  BottomNavItem _currentItem = BottomNavItem.TIMELINE;

  @override
  BottomNavItem get currentItem => _currentItem;

  DestinationManager _currentDestinationManager;

  @override
  void pickItem(int i) {
    switch (i) {
      case 0:
        _currentItem = BottomNavItem.TIMELINE;
        break;
      case 1:
        _currentItem = BottomNavItem.DEPUTIES;
        break;
      case 2:
        _currentItem = BottomNavItem.SPEECHES;
        break;
      case 3:
        _currentItem = BottomNavItem.VOTING;
        break;
      case 4:
        _currentItem = BottomNavItem.SETTINGS;
        break;
    }
    _currentDestinationManager = null;
  }

  DestinationManager getDestinationManager(BuildContext context) {
    if (_currentDestinationManager == null) {
      switch (currentItem) {
        case BottomNavItem.DEPUTIES:
          _currentDestinationManager = DestinationManager(DeputiesListDestination());
          break;
        case BottomNavItem.SPEECHES:
          _currentDestinationManager = DestinationManager(SpeechesListDestination());
          break;
        case BottomNavItem.SETTINGS:
          _currentDestinationManager = DestinationManager(SettingsScreenDestination());
          break;
        default:
          _currentDestinationManager = DestinationManager(TimelineScreenDestination());
          break;
      }
    }
    return _currentDestinationManager;
  }

}