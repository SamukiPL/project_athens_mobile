import 'package:project_athens/athens_core/presentation/base_blocs/base_change_notifier.dart';

class StepSearchBarBloc extends BaseChangeNotifier {

  bool _isVisible = false;
  bool get isVisible => _isVisible;

  void hide() {
    _isVisible = false;
    notifyListeners();
  }

  void show() {
    _isVisible = true;
    notifyListeners();
  }

}