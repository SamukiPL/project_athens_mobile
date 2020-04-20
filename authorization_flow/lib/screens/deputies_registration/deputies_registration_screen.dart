import 'package:athens_core/injections/module.dart';
import 'package:athens_core/presentation/base_screen.dart';
import 'package:authorization_flow/injections/deputies_registration_module.dart';
import 'package:authorization_flow/screens/deputies_registration/deputies_registration_bloc.dart';
import 'package:authorization_flow/screens/deputies_registration/list/deputies_list.dart';
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
    return [DeputiesRegistrationModule(context)];
  }



}