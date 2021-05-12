import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/authorization_flow/screens/registration/registration_bloc.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/registration_steps.dart';
import 'package:project_athens/authorization_flow/screens/registration/stepper/registration_stepper_bloc.dart';
import 'package:provider/provider.dart';

class RegistrationStepperHeader extends StatelessWidget {

  final AppLocalizations _localization;

  const RegistrationStepperHeader(this._localization, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final registrationBloc = Provider.of<RegistrationBloc>(context);

    return Consumer<RegistrationStepperBloc>(
      builder: (context, bloc, _) => Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            CircularPercentIndicator(
              radius: 50,
              lineWidth: 5,
              percent: (bloc.currentStep.index + 1)/3,
              backgroundColor: Colors.white,
              progressColor: theme.accentColor,
              animateFromLastPercent: true,
              animation: true,
              animationDuration: 350,
              center: Text(
                "${bloc.currentStep.index + 1} z 3",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      bloc.currentStep.getCurrentStepTitle(_localization),
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white
                      ),
                    ),
                    bloc.currentStep.getNextStepTitle(_localization) != ""
                        ? Text(
                            bloc.currentStep.getNextStepTitle(_localization),
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          )
                    : Container(),
                    StreamProvider.value(
                      value: bloc.headerHelperLine,
                      initialData: "",
                      child: Consumer<String>(
                        builder: (context, line, _) =>
                          Text(
                              line,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            )
                      )
                    )
                  ],
                ),
              )

            ),
            GestureDetector(
              onTap: () => registrationBloc.headerIconAction(),
              child: Icon(
                bloc.currentStep.getStepIcon(),
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }

}