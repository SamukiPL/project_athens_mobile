import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/ext/list_extension.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/athens_core/injections/module_widget.dart';
import 'package:project_athens/athens_core/navigation/bottom_navigation_bloc.dart';
import 'package:project_athens/athens_core/presentation/base_screen.dart';

class DestinationManager {
  final BottomNavItem bottomNavItem;

  DestinationManager(Destination destination, this.bottomNavItem) {
    popStack.add(destination);
  }

  @protected
  List<Destination> popStack = [];

  Widget currentScreen() => popStack.last.getScreen();

  List<Module> getScreenModules(BuildContext context) =>
      popStack.last.getScreenModules(context);

  bool goBack(BuildContext context) {
    popStack.removeLastIfPossible();
    Navigator.maybePop(context);
    return false;
  }

  void popToFirst(BuildContext context) {
    while (popStack.isThereMoreThanOneItem()) {
      popStack.removeLastIfPossible();
      Navigator.maybePop(context);
    }
  }

  void goToDestination(BuildContext context, Destination destination) {
    if (popStack.last == destination) return;

    push(
        context,
        MaterialPageRoute(
          builder: (context) => ModuleWidget(
              providers: getScreenModules(context), child: currentScreen()),
        ),
        destination);
  }

  void push<T>(
      BuildContext context, Route<T> route, Destination destination) {
    if (destination.replace) {
      popStack.removeLast();
      Navigator.pushReplacement(context, route);
    } else {
      Navigator.push(context, route);
    }
    popStack.add(destination);
  }
}

abstract class Destination<SCREEN extends BaseScreen> {
  final BottomNavItem bottomNavItem;

  final bool replace;

  Destination(this.bottomNavItem, {this.replace = false});

  SCREEN getScreen();

  List<Module> getScreenModules(BuildContext context);
}
