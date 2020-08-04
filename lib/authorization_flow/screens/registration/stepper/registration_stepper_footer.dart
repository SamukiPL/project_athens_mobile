import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/authorization_flow/screens/registration/stepper/registration_stepper_bloc.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/registration_steps.dart';
import 'package:provider/provider.dart';

class RegistrationStepperFooter extends StatelessWidget {

  final VoidCallback _positiveButtonCallback;
  final VoidCallback _negativeButtonCallback;

  const RegistrationStepperFooter(this._positiveButtonCallback, this._negativeButtonCallback, {Key key}) : super(key: key);

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
            FlatButton(
              child: Text(
                bloc.currentStep.getNegativeButtonText(localization),
                style: TextStyle(
                  color: Colors.grey
                ),
              ),
              onPressed: _negativeButtonCallback,
            ),
            RaisedButton(
              child: Text(
                bloc.currentStep.getPositiveButtonText(localization),
                style: TextStyle(
                  color: Colors.white
                ),
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