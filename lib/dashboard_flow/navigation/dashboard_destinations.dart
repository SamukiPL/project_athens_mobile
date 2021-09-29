import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/athens_core/navigation/bottom_navigation_bloc.dart';
import 'package:project_athens/athens_core/navigation/destination_manager.dart';
import 'package:project_athens/dashboard_flow/injections/dashboard_module.dart';
import 'package:project_athens/dashboard_flow/screens/dashboard/dashboard_screen.dart';

class DashboardScreenDestination extends Destination<DashboardScreen> {
  DashboardScreenDestination() : super(BottomNavItem.DASHBOARD);

  @override
  DashboardScreen getScreen() => DashboardScreen();

  @override
  List<Module> getScreenModules(BuildContext context) => [DashboardModule(context)];
}