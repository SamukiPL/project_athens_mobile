import 'package:project_athens/athens_core/presentation/base_blocs/base_change_notifier.dart';
import 'package:project_athens/athens_core/ext/list_extension.dart';

enum LoginDestination { LOGIN, REGISTER, RESET_PASSWORD }

class LoginNavigationBloc extends BaseChangeNotifier {
  List<LoginDestination> _popStack = List.of([LoginDestination.LOGIN]);

  LoginDestination get currentScreen => _popStack.last;

  bool _systemBackActive = true;

  void addItem(LoginDestination destination) {
    _popStack.add(destination);
    notifyListeners();
  }

  void setItem(LoginDestination destination) {
    _popStack = List.of([destination]);
    notifyListeners();
  }

  /// Should be used only after successful registration! On Deputies Chooser Step
  void disableGoBack() {
    _popStack = List.of([LoginDestination.REGISTER]);
    _systemBackActive = false;
  }

  bool goBack() {
    if (_popStack.length == 1) return _systemBackActive;

    _popStack.removeLastIfPossible();
    notifyListeners();
    return false;
  }
}
