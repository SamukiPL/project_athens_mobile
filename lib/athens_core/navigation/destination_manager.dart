import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/ext/list_extension.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/athens_core/presentation/base_blocs/base_change_notifier.dart';
import 'package:project_athens/athens_core/presentation/base_screen.dart';
import 'package:project_athens/main/presentation/main_widget.dart';

class DestinationManager extends BaseChangeNotifier {

  DestinationManager(Destination destination) {
    popStack.add(destination);
  }

  @protected
  List<Destination> popStack = List();

  Widget currentScreen() => popStack.last.getScreen();

  List<Module> getScreenModules(BuildContext context) => popStack.last.getScreenModules(context);

  bool goBack() {
    popStack.removeLastIfPossible();
    return true;
  }

  void goToDestination(BuildContext context, Destination destination) {
    popStack.add(destination);

    Navigator.push(context, MaterialPageRoute(
        builder: (context) => MainWidget()
    ));
  }

}

abstract class Destination<SCREEN extends BaseScreen> {
  SCREEN getScreen();

  List<Module> getScreenModules(BuildContext context);
}