import 'package:athens_core/navigation/bottom_navigation_bloc.dart';
import 'package:athens_core/navigation/destination_manager.dart';
import 'package:timeline_flow/navigation/timeline_destination_manager.dart';

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

  DestinationManager getDestinationManager() {
    switch (this) {
      default:
        return TimelineDestinationManager();
        break;
    }
  }

}