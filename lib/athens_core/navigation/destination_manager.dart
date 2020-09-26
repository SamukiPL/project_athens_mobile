import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/athens_core/presentation/base_change_notifier.dart';

abstract class DestinationManager extends BaseChangeNotifier {

  Widget currentScreen();

  List<Module> getScreenModules(BuildContext context);

  bool goBack();

}