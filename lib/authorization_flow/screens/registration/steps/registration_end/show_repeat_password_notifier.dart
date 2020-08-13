import 'package:project_athens/athens_core/presentation/base_change_notifier.dart';

class ShowRepeatPasswordNotifier extends BaseChangeNotifier {

  bool _showRepeatPassword = false;

  bool get showRepeatPassword => _showRepeatPassword;

  void manageAnimation(bool newValue) {
    if (newValue == _showRepeatPassword)
      return;

    _showRepeatPassword = newValue;
    notifyListeners();
  }

}