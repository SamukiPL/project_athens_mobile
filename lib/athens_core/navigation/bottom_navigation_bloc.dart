import 'dart:core';

import 'package:project_athens/athens_core/navigation/navigation_event.dart';
import 'package:project_athens/athens_core/presentation/base_blocs/base_change_notifier.dart';
import 'package:project_athens/dashboard_flow/navigation/dashboard_destinations.dart';
import 'package:project_athens/deputies_flow/navigation/deputies_destinations.dart';
import 'package:project_athens/guest_flow/navigation/guest_destinations.dart';
import 'package:project_athens/speeches_flow/navigation/speeches_destinations.dart';
import 'package:project_athens/timeline_flow/navigation/timeline_destinations.dart';
import 'package:project_athens/voting_flow/navigation/voting_destinations.dart';
import 'package:rxdart/rxdart.dart';

import 'destination_manager.dart';

enum BottomNavItem {
  DASHBOARD, TIMELINE, DEPUTIES, SPEECHES, VOTING
}

class BottomNavigationBloc extends BaseChangeNotifier {

  BottomNavItem _currentItem = BottomNavItem.DASHBOARD;
  BottomNavItem? _previousItem;

  BottomNavItem get currentItem => _currentItem;

  final PublishSubject<NavigationEvent> _destination = PublishSubject();

  Stream<NavigationEvent> get destination => _destination.stream;

  void pickItem(int i) {
    _previousItem = _currentItem;
    _currentItem = BottomNavItem.values[i];
    notifyListeners();
  }

  void setItem(BottomNavItem item) {
    _previousItem = _currentItem;
    _currentItem = item;
    notifyListeners();
  }

  bool wasItemReselected(BottomNavItem navigatorItem) => currentItem == _previousItem && navigatorItem == currentItem;

  void goToDestination(Destination destination, {
    bool replaceBottomNavItem = true,
  }) {
    if (_currentItem != destination.bottomNavItem && replaceBottomNavItem) {
      setItem(destination.bottomNavItem);
    }
    final newEvent = NavigationEvent.goTo(destination, false);
    _destination.add(newEvent);
  }

  void pop() {
    final newEvent = NavigationEvent.pop(currentItem);
    _destination.add(newEvent);
  }

  @override
  void dispose() {
    _destination.close();
    super.dispose();
  }
}

extension BottomNavItemExtension on BottomNavItem {

  Destination getInitialDestination(bool isLogged) {
    switch(this) {
      case BottomNavItem.TIMELINE:
        return getBlockadeIfNotLogged(TimelineScreenDestination(), BottomNavItem.TIMELINE, isLogged);
      case BottomNavItem.DEPUTIES:
        return DeputiesListDestination();
      case BottomNavItem.SPEECHES:
        return SpeechesListDestination();
      case BottomNavItem.VOTING:
        return VotesListDestination();
      case BottomNavItem.DASHBOARD:
        return getBlockadeIfNotLogged(DashboardScreenDestination(), BottomNavItem.DASHBOARD, isLogged);
      default:
        throw new ArgumentError("There is no more BottomNavItems");
    }
  }

  Destination getBlockadeIfNotLogged(Destination correctDestination,
      BottomNavItem navItem, bool isLogged) => (isLogged) ? correctDestination : GuestBlockadeDestination(navItem);

}
