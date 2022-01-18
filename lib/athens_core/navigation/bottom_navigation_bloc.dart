import 'package:project_athens/athens_core/navigation/navigation_event.dart';
import 'package:project_athens/athens_core/presentation/base_blocs/base_change_notifier.dart';
import 'package:project_athens/dashboard_flow/navigation/dashboard_destinations.dart';
import 'package:project_athens/deputies_flow/navigation/deputies_destinations.dart';
import 'package:project_athens/more_flow/navigation/more_navigation.dart';
import 'package:project_athens/speeches_flow/navigation/speeches_destinations.dart';
import 'package:project_athens/timeline_flow/navigation/timeline_destinations.dart';
import 'package:project_athens/voting_flow/navigation/voting_destinations.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:core';

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

  void goToDestination(Destination destination) {
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
      case BottomNavItem.DASHBOARD:
        return DashboardScreenDestination();
        break;
      default:
        throw new ArgumentError("There is no more BottomNavItems");
    }
  }

}