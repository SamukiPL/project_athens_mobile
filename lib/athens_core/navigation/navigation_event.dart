
import 'package:project_athens/athens_core/navigation/bottom_navigation_bloc.dart';
import 'package:project_athens/athens_core/navigation/destination_manager.dart';

class NavigationEvent {
  NavigationEvent._();

  factory NavigationEvent.goTo(Destination destination, bool redirectionToDifferentTab) = GoToEvent;
  factory NavigationEvent.pop(BottomNavItem currentNavItem) = PopEvent;
}

class GoToEvent extends NavigationEvent {
  final Destination destination;
  final bool redirectionToDifferentTab;

  GoToEvent(this.destination, this.redirectionToDifferentTab) : super._();
}
class PopEvent extends NavigationEvent {
  final BottomNavItem currentNavItem;

  PopEvent(this.currentNavItem): super._();
}