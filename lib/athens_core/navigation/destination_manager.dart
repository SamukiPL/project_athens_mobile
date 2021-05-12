import 'package:flutter/cupertino.dart';
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
    popStack.add(destination);

    push(
        context,
        MaterialPageRoute(
          builder: (context) => ModuleWidget(
              providers: getScreenModules(context), child: currentScreen()),
        ),
        destination.replace);
  }

  void push<T extends Object>(
      BuildContext context, Route<T> route, bool replace) {
    if (replace) {
      Navigator.pushReplacement(context, route);
    } else {
      Navigator.push(context, route);
    }
  }
}

abstract class Destination<SCREEN extends BaseScreen> {
  final BottomNavItem bottomNavItem;

  final bool replace;

  Destination(this.bottomNavItem, {this.replace = false});

  SCREEN getScreen();

  List<Module> getScreenModules(BuildContext context);
}
