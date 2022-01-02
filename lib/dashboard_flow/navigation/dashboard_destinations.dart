import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/athens_core/navigation/bottom_navigation_bloc.dart';
import 'package:project_athens/athens_core/navigation/destination_manager.dart';
import 'package:project_athens/dashboard_flow/injections/dashboard_module.dart';
import 'package:project_athens/dashboard_flow/injections/dashboard_notifications_module.dart';
import 'package:project_athens/dashboard_flow/screens/dashboard/dashboard_screen.dart';
import 'package:project_athens/dashboard_flow/screens/notifications_screen/notifications_screen.dart';

class DashboardScreenDestination extends Destination<DashboardScreen> {
  DashboardScreenDestination() : super(BottomNavItem.DASHBOARD);

  @override
  DashboardScreen getScreen() => DashboardScreen();

  @override
  List<Module> getScreenModules(BuildContext context) => [DashboardModule(context)];
}

class DashboardNotificationsScreenDestination extends Destination<NotificationsScreen> {
  DashboardNotificationsScreenDestination() : super(BottomNavItem.DASHBOARD);

  @override
  NotificationsScreen getScreen() => NotificationsScreen();

  @override
  List<Module> getScreenModules(BuildContext context) => [DashboardNotificationsModule(context)];
}