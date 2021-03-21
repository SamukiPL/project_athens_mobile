import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/athens_core/navigation/bottom_navigation_bloc.dart';
import 'package:project_athens/athens_core/presentation/base_screen.dart';
import 'package:project_athens/deputy_subscription/presentation/deputies_registration/deputies_registration_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/pagination/paging_list.dart';

class DeputiesRegistrationScreen extends BaseScreen<DeputiesRegistrationBloc> {
  @override
  String get appBarTitle => "Subscribe";

  @override
  bool get showBackArrow => false;

  @override
  BottomNavItem get currentBottomBarItem {

  }

  @override
  Widget buildBody(BuildContext context, DeputiesRegistrationBloc bloc) {
    return PagingList(bloc.adapter);
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