import 'package:flutter/widgets.dart';
import 'package:project_athens/deputies_flow/navigation/deputies_destinations.dart';
import 'package:project_athens/settings_flow/navigation/settings_destinations.dart';
import 'package:project_athens/speeches_flow/navigation/speeches_destinations.dart';
import 'package:project_athens/timeline_flow/navigation/timeline_destinations.dart';
import 'package:project_athens/voting_flow/navigation/voting_destinations.dart';
import 'dart:core';

import 'destination_manager.dart';

enum BottomNavItem {
  TIMELINE, DEPUTIES, SPEECHES, VOTING, SETTINGS
}

abstract class BottomNavigationBloc {
  BottomNavItem get currentItem;

  void pickItem(int i);

  DestinationManager getDestinationManager(BuildContext context);
}

extension BottomNavItemExtension on BottomNavItem {

  DestinationManager getDestinationManager() {
    switch(this) {
      case BottomNavItem.TIMELINE:
        return DestinationManager(TimelineScreenDestination());
        break;
      case BottomNavItem.DEPUTIES:
        return DestinationManager(DeputiesListDestination());
        break;
      case BottomNavItem.SPEECHES:
        return DestinationManager(SpeechesListDestination());
        break;
      case BottomNavItem.VOTING:
        return DestinationManager(VotesListDestination(BottomNavItem.VOTING));
        break;
      case BottomNavItem.SETTINGS:
        return DestinationManager(SettingsScreenDestination());
        break;
      default:
        throw new ArgumentError("There is no more BottomNavItems");
    }
  }

}