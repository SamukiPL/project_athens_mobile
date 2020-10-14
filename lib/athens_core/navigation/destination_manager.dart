import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/ext/list_extension.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/athens_core/presentation/base_change_notifier.dart';
import 'package:project_athens/athens_core/presentation/base_screen.dart';

abstract class DestinationManager<DESTINATION extends Destination> extends BaseChangeNotifier {
  @protected
  List<DESTINATION> popStack = List();

  Widget currentScreen() => popStack.last.getScreen();

  List<Module> getScreenModules(BuildContext context) => popStack.last.getScreenModules(context);

  bool goBack() {
    popStack.removeLastIfPossible();
    return true;
  }

}

abstract class Destination<SCREEN extends BaseScreen> {
  SCREEN getScreen();

  List<Module> getScreenModules(BuildContext context);
}