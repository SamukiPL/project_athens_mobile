import 'package:project_athens/athens_core/presentation/base_blocs/base_change_notifier.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/registration_steps.dart';
import 'package:rxdart/rxdart.dart';

class RegistrationStepperBloc extends BaseChangeNotifier {

  RegistrationStep _currentStep;

  RegistrationStepperBloc(this._currentStep);

  BehaviorSubject<String> _headerHelperLineSource = new BehaviorSubject<String>();

  RegistrationStep get currentStep => _currentStep;

  Stream<String> get headerHelperLine => _headerHelperLineSource.stream.startWith("");

  void setStep(RegistrationStep step) {
    _currentStep = step;
    notifyListeners();
  }

  void setHeaderHelperLine(String line) {
    _headerHelperLineSource.add(line);
  }

  @override
  void dispose() {
    _headerHelperLineSource.close();

    super.dispose();
  }

}