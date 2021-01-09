import 'package:project_athens/athens_core/presentation/base_blocs/base_change_notifier.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/registration_steps.dart';

class RegistrationStepperBloc extends BaseChangeNotifier {

  RegistrationStep _currentStep;

  RegistrationStepperBloc(this._currentStep);

  RegistrationStep get currentStep => _currentStep;

  void setStep(RegistrationStep step) {
    _currentStep = step;
    notifyListeners();
  }

}