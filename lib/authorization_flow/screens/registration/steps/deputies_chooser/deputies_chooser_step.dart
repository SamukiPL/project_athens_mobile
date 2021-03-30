import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/navigation/app_navigation.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/base_registration_step.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/deputies_chooser/deputies_chooser_step_bloc.dart';
import 'package:project_athens/pagination/paging_list.dart';
import 'package:provider/provider.dart';

class DeputiesChooserStep extends BaseRegistrationStep<DeputiesChooserBloc> {

  @override
  Widget buildStepBody(BuildContext context, DeputiesChooserBloc bloc) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Container(
            height: 0,
            child: PagingList(bloc.adapter, paginationIncluded: false,),
          ),
        )
      ]
    );
  }

  @override
  void positiveButtonAction(BuildContext context, DeputiesChooserBloc bloc) {
    bloc();
  }

  @override
  void negativeButtonAction(BuildContext context) {
    var appNavigation = Provider.of<AppNavigation>(context, listen: false);
    appNavigation.goToMainWidget(context);
  }

}