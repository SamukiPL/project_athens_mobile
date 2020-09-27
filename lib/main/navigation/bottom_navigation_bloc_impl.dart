import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/navigation/bottom_navigation_bloc.dart';
import 'package:project_athens/athens_core/navigation/destination_manager.dart';
import 'package:project_athens/settings_flow/navigation/settings_destination_manager.dart';
import 'package:project_athens/timeline_flow/navigation/timeline_destination_manager.dart';

class BottomNavigationBlocImpl extends BottomNavigationBloc {

  BottomNavItem _currentItem = BottomNavItem.TIMELINE;

  @override
  BottomNavItem get currentItem => _currentItem;

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
        _currentItem = BottomNavItem.SEARCH;
        break;
      case 3:
        _currentItem = BottomNavItem.VOTING;
        break;
      case 4:
        _currentItem = BottomNavItem.SETTINGS;
        break;
    }
    notifyListeners();
  }

}

extension BottomNavItemExt on BottomNavItem {

  DestinationManager getDestinationManager(BuildContext context) {
    switch (this) {
      case BottomNavItem.SETTINGS:
        return SettingsDestinationManager();
        break;
      default:
        return TimelineDestinationManager(context);
        break;
    }
  }

}