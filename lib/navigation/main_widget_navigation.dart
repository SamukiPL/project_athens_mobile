import 'package:athens_core/presentation/base_change_notifier.dart';
import 'package:project_athens/navigation/main_destination.dart';

class MainWidgetNavigation extends BaseChangeNotifier {

  List<MainDestination> _popStack = List.of([MainDestination.deputiesRegistration()]);

  MainDestination get currentDestination => _popStack.last;

  void setItem(MainDestination destination) {
    _popStack.add(destination);
    notifyListeners();
  }

}