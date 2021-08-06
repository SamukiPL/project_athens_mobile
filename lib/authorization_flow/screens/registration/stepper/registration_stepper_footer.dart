import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/authorization_flow/screens/registration/stepper/registration_stepper_bloc.dart';
import 'package:project_athens/authorization_flow/screens/registration/stepper/stepper_button_state_bloc.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/registration_steps.dart';
import 'package:provider/provider.dart';

class RegistrationStepperFooter extends StatelessWidget {

  final VoidCallback _positiveButtonCallback;
  final VoidCallback _negativeButtonCallback;

  const RegistrationStepperFooter(this._positiveButtonCallback, this._negativeButtonCallback, {Key? key}) : super(key: key);

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
                  style: TextStyle(
                    color: Colors.grey
                  ),
                ),
                onPressed: _negativeButtonCallback,
              ),
            ),
            RaisedButton(
              child: Stack(
                alignment: Alignment.center,
                children: [
                Consumer<StepperButtonStateBloc>(
                  child: Text(
                    bloc.currentStep.getPositiveButtonText(localization),
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                  builder: (context, bloc, child) => Visibility(
                    visible: bloc.state == StepperButtonState.IDLE,
                    child: child!,
                  ),
                ),
                Consumer<StepperButtonStateBloc>(
                  child: Container(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                  builder: (context, bloc, child) => Visibility(
                    visible: bloc.state == StepperButtonState.LOADING,
                    child: child!,
                  ),
                )
                ],
              ),
              onPressed: _positiveButtonCallback,
              color: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
            )
          ],
        ),
      ),
    );
  }

}