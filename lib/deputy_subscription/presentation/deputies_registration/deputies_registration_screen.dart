import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/athens_core/presentation/base_screen.dart';
import 'package:project_athens/deputy_subscription/presentation/deputies_registration/deputies_registration_bloc.dart';
import 'package:project_athens/deputy_subscription/presentation/deputies_registration/list/deputies_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeputiesRegistrationScreen extends BaseScreen<DeputiesRegistrationBloc> {
  @override
  String get appBarTitle => "Subscribe";

  @override
  bool get showBackArrow => false;

  @override
  Widget buildBody(BuildContext context, DeputiesRegistrationBloc bloc) {
    return DeputiesList(bloc.adapter);
  }

  @override
  List<Module> getProviders(BuildContext context) {
    // TODO: implement getProviders
    return null;
  }

  @override
  Widget buildFloatingActionButton(BuildContext context, DeputiesRegistrationBloc bloc) {
    // TODO: implement buildFloatingActionButton
    return null;
  }

}