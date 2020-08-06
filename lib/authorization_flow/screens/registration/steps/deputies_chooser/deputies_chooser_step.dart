import 'package:flutter/material.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/base_registration_step.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/deputies_chooser/deputies_chooser_step_bloc.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/deputies_chooser/list/deputies_list.dart';
import 'package:provider/provider.dart';

class DeputiesChooserStep extends BaseRegistrationStep {

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<DeputiesRegistrationBloc>(context);
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Container(
            height: 0,
            child: DeputiesList(bloc.adapter),
          ),
        )
      ]
    );
  }

}