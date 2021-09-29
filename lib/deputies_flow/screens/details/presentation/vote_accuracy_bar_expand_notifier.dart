import 'package:project_athens/athens_core/presentation/base_blocs/base_change_notifier.dart';

class VoteAccuracyBarExpandNotifier extends BaseChangeNotifier {
  bool _state = false;

  bool get isOpen => _state;

  toggle() {
    _state = !_state;

    this.notifyListeners();
  }
}
