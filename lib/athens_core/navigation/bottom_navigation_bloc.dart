import 'package:flutter/widgets.dart';

import 'destination_manager.dart';

enum BottomNavItem {
  TIMELINE, DEPUTIES, SPEECHES, VOTING, SETTINGS
}

abstract class BottomNavigationBloc {
  BottomNavItem get currentItem;

  void pickItem(int i);

  DestinationManager getDestinationManager(BuildContext context);
}