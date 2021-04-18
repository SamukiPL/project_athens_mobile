import 'package:project_athens/athens_core/presentation/base_blocs/base_change_notifier.dart';
import 'package:project_athens/deputies_flow/navigation/deputies_destinations.dart';
import 'package:project_athens/settings_flow/navigation/settings_destinations.dart';
import 'package:project_athens/speeches_flow/navigation/speeches_destinations.dart';
import 'package:project_athens/timeline_flow/navigation/timeline_destinations.dart';
import 'package:project_athens/voting_flow/navigation/voting_destinations.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:core';

import 'destination_manager.dart';

enum BottomNavItem {
  TIMELINE, DEPUTIES, SPEECHES, VOTING, SETTINGS
}

class BottomNavigationBloc extends BaseChangeNotifier {

  BottomNavItem _currentItem = BottomNavItem.TIMELINE;

  BottomNavItem get currentItem => _currentItem;

  final PublishSubject<NavigationEvent> _destination = PublishSubject();

  Stream<NavigationEvent> get destination => _destination.stream;

  void pickItem(int i) {
    _currentItem = BottomNavItem.values[i];
    notifyListeners();
  }

  void setItem(BottomNavItem item) {
    _currentItem = item;
    notifyListeners();
  }

  void goToDestination(Destination destination) {
    final newEvent = NavigationEvent(destination, currentItem != destination.bottomNavItem);
    _destination.add(newEvent);
  }

  @override
  void dispose() {
    _destination.close();
    super.dispose();
  }
}

class NavigationEvent {
  final Destination destination;
  final bool redirectionToDifferentTab;
  NavigationEvent(this.destination, this.redirectionToDifferentTab);
}

extension BottomNavItemExtension on BottomNavItem {

  Destination getInitialDestination() {
    switch(this) {
      case BottomNavItem.TIMELINE:
        return TimelineScreenDestination();
        break;
      case BottomNavItem.DEPUTIES:
        return DeputiesListDestination();
        break;
      case BottomNavItem.SPEECHES:
        return SpeechesListDestination();
        break;
      case BottomNavItem.VOTING:
        return VotesListDestination();
        break;
      case BottomNavItem.SETTINGS:
        return SettingsScreenDestination();
        break;
      default:
        throw new ArgumentError("There is no more BottomNavItems");
    }
  }

}