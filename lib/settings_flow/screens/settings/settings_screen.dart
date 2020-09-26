import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/presentation/base_screen.dart';
import 'package:project_athens/settings_flow/screens/settings/settings_bloc.dart';

class SettingsScreen extends BaseScreen<SettingsBloc> {
  @override
  String get appBarTitle => "Settings";
  @override
  bool get showBackArrow => false;

  @override
  Widget buildBody(BuildContext context, SettingsBloc bloc) {
    return Container();
  }

  @override
  Widget buildFloatingActionButton(BuildContext context, SettingsBloc bloc) {
    return null;
  }


}