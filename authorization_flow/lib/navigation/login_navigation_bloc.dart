import 'package:athens_core/presentation/base_change_notifier.dart';

enum LoginDestination { LOGIN, REGISTER, RESET_PASSWORD }

class LoginNavigationBloc extends BaseChangeNotifier {
  LoginDestination _currentScreen = LoginDestination.LOGIN;

  LoginDestination get currentScreen => _currentScreen;

  void setItem(LoginDestination destination) {
    _currentScreen = destination;
    notifyListeners();
  }
}
