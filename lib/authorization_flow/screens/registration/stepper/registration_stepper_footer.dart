import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/authorization_flow/screens/registration/stepper/registration_stepper_bloc.dart';
import 'package:project_athens/authorization_flow/screens/registration/stepper/stepper_button_state_bloc.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/registration_steps.dart';
import 'package:provider/provider.dart';

class RegistrationStepperFooter extends StatelessWidget {
  final VoidCallback _positiveButtonCallback;
  final VoidCallback _negativeButtonCallback;

  const RegistrationStepperFooter(
      this._positiveButtonCallback, this._negativeButtonCallback,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = Provider.of<AppLocalizations>(context);
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.white,
      child: Consumer<RegistrationStepperBloc>(
        builder: (context, bloc, _) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Visibility(
              visible: bloc.currentStep != RegistrationStep.DEPUTIES_CHOOSER, //TODO remove after implementation
              child: TextButton(
                child: Text(
                  bloc.currentStep.getNegativeButtonText(localization),
                  style: TextStyle(color: Colors.grey),
                ),
                onPressed: _negativeButtonCallback,
              ),
            ),
            Consumer<StepperButtonStateBloc>(
              builder: (context, stateBloc, _) => ElevatedButton(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Visibility(
                      visible: stateBloc.state != StepperButtonState.LOADING,
                      child: Text(
                        bloc.currentStep.getPositiveButtonText(localization),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Visibility(
                      visible: stateBloc.state == StepperButtonState.LOADING,
                      child: Container(
                        height: 25,
                        width: 25,
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
                onPressed: (stateBloc.state != StepperButtonState.DISABLE)
                    ? _positiveButtonCallback
                    : null,
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
