import 'package:flutter/src/widgets/framework.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/athens_core/navigation/bottom_navigation_bloc.dart';
import 'package:project_athens/athens_core/navigation/destination_manager.dart';
import 'package:project_athens/guest_flow/injections/guest_blockade_module.dart';
import 'package:project_athens/guest_flow/screens/guest_blockade_screen.dart';

class GuestBlockadeDestination extends Destination<GuestBlockadeScreen> {
  GuestBlockadeDestination(BottomNavItem bottomNavItem) : super(bottomNavItem);

  @override
  GuestBlockadeScreen getScreen() => GuestBlockadeScreen();

  @override
  List<Module> getScreenModules(BuildContext context) => [GuestBlockadeModule(context)];

}