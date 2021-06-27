import 'package:project_athens/athens_core/presentation/base_blocs/base_change_notifier.dart';

class VoteAccuracyBarExpandNotifier extends BaseChangeNotifier {
  bool _state = false;

  bool get isOpen => _state;

  toggle() {
    if (_state == true) {
      _state = false;
    } else {
      _state = true;
    }

    this.notifyListeners();
  }
}