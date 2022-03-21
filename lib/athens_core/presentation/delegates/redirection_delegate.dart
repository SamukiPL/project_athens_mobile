import 'package:flutter/widgets.dart';
import 'package:project_athens/athens_core/navigation/bottom_navigation_bloc.dart';
import 'package:project_athens/athens_core/navigation/destination_manager.dart';
import 'package:provider/provider.dart';

mixin RedirectionDelegate {
  void goToDestination(
    BuildContext context,
    Destination destination, {
    bool replaceBottomNavItem = true,
  }) {
    final navigationBloc = Provider.of<BottomNavigationBloc>(context, listen: false);
    navigationBloc.goToDestination(destination, replaceBottomNavItem: replaceBottomNavItem);
  }
}
