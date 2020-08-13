import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/registration_steps.dart';
import 'package:project_athens/authorization_flow/screens/registration/stepper/registration_stepper_bloc.dart';
import 'package:provider/provider.dart';

class RegistrationStepperHeader extends StatelessWidget {

  final AppLocalizations _localization;

  const RegistrationStepperHeader(this._localization, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RegistrationStepperBloc>(
      builder: (context, bloc, _) => Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            CircularPercentIndicator(
              radius: 100,
              lineWidth: 10,
              percent: (bloc.currentStep.index + 1)/3,
              backgroundColor: Colors.white,
              progressColor: Colors.green,
              animateFromLastPercent: true,
              animation: true,
              animationDuration: 350,
              center: Text(
                "${bloc.currentStep.index + 1} z 3",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            bloc.currentStep.getCurrentStepTitle(_localization),
                            style: TextStyle(
                                fontSize: 28,
                                color: Colors.white
                            ),
                            textAlign: TextAlign.center,
                            softWrap: true,
                          ),
                        ),
                        Icon(
                          Icons.help_outline,
                          color: Colors.white,
                        )
                      ],
                    ),
                    margin: EdgeInsets.only(bottom: 8),
                  ),
                  Text(
                    bloc.currentStep.getNextStepTitle(_localization),
                    style: TextStyle(
                        fontSize: 10,
                        color: Colors.white
                    ),
                    softWrap: true,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}