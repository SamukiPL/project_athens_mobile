import 'package:project_athens/athens_core/presentation/base_change_notifier.dart';

enum BottomNavItem {
  TIMELINE, DEPUTIES, SEARCH, VOTING, SETTINGS
}

abstract class BottomNavigationBloc extends BaseChangeNotifier {
  BottomNavItem get currentItem;

  void pickItem(int i);
}