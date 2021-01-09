import 'package:project_athens/athens_core/presentation/base_blocs/base_change_notifier.dart';

enum StepperButtonState { IDLE, LOADING }

class StepperButtonStateBloc extends BaseChangeNotifier {

  StepperButtonState _state = StepperButtonState.IDLE;

  StepperButtonState get state => _state;

  void changeState(StepperButtonState state) {
    _state = state;
    notifyListeners();
  }


}