import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'base_registration_step_bloc.dart';

abstract class BaseRegistrationStep<BLOC extends BaseRegistrationStepBloc> extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<BLOC>(context);
    return StreamProvider<StepAction?>.value(
      initialData: null,
      value: bloc.stepAction,
      updateShouldNotify: (_, current) {
        if (current != null)
          listenToAction(context, bloc, current);
        return false;
      },
      child: Consumer<StepAction?>(
        builder: (context, _, child) => child!,
        child: buildStepBody(context, bloc)
      )
    );
  }

  Widget buildStepBody(BuildContext context, BLOC bloc);

  void listenToAction(BuildContext context, BLOC bloc, StepAction action) {
    switch(action) {
      case StepAction.NEGATIVE:
        negativeButtonAction(context);
        break;
      case StepAction.POSITIVE:
        positiveButtonAction(context, bloc);
        break;
    }
  }

  void negativeButtonAction(BuildContext context) {}

  void positiveButtonAction(BuildContext context, BLOC bloc) {}

}