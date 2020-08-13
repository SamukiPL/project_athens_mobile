import 'package:project_athens/athens_core/presentation/base_change_notifier.dart';

class ShowRepeatEmailNotifier extends BaseChangeNotifier {

  bool _showRepeatEmail = false;

  bool get showRepeatEmail => _showRepeatEmail;

  void manageAnimation(bool newValue) {
    if (newValue == _showRepeatEmail)
      return;

    _showRepeatEmail = newValue;
    notifyListeners();
  }

}