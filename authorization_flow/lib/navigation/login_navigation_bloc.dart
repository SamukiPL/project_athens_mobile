import 'package:athens_core/presentation/base_change_notifier.dart';
import 'package:athens_core/ext/list_extension.dart';

enum LoginDestination { LOGIN, REGISTER, RESET_PASSWORD }

class LoginNavigationBloc extends BaseChangeNotifier {
  List<LoginDestination> _popStack = List.of([LoginDestination.LOGIN]);

  LoginDestination get currentScreen => _popStack.last;

  void setItem(LoginDestination destination) {
    _popStack.add(destination);
    notifyListeners();
  }

  bool goBack() {
    if (_popStack.length == 1) return true;

    _popStack.removeLastIfPossible();
    notifyListeners();
    return false;
  }
}
