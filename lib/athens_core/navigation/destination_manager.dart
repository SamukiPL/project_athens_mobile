import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/ext/list_extension.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/athens_core/injections/module_widget.dart';
import 'package:project_athens/athens_core/navigation/bottom_navigation_bloc.dart';
import 'package:project_athens/athens_core/navigation/destination_widget.dart';
import 'package:project_athens/athens_core/presentation/base_screen.dart';

class DestinationManager {

  final BottomNavItem bottomNavItem;

  DestinationManager(Destination destination, this.bottomNavItem) {
    popStack.add(destination);
  }

  @protected
  List<Destination> popStack = [];

  Widget currentScreen() => popStack.last.getScreen();

  List<Module> getScreenModules(BuildContext context) => popStack.last.getScreenModules(context);

  bool goBack() {
    popStack.removeLastIfPossible();
    return true;
  }

  void popToFirst(BuildContext context) {
    while (popStack.isThereMoreThanOneItem()) {
      popStack.removeLast();
      Navigator.pop(context);
    }
  }

  void goToDestination(BuildContext context, Destination destination) {
    popStack.add(destination);

    Navigator.push(context, MaterialPageRoute(
        builder: (context) => DestinationWidget(
          destinationManager: this,
          moduleWidget: ModuleWidget(
              providers: getScreenModules(context),
              child: currentScreen()),
        )),
    );
  }

}

abstract class Destination<SCREEN extends BaseScreen> {
  final BottomNavItem bottomNavItem;

  Destination(this.bottomNavItem);

  SCREEN getScreen();

  List<Module> getScreenModules(BuildContext context);
}