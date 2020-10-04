import 'package:flutter/src/widgets/framework.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/athens_core/navigation/destination_manager.dart';
import 'package:project_athens/athens_core/presentation/base_screen.dart';
import 'package:project_athens/deputies_flow/injections/deputies_list_module.dart';
import 'package:project_athens/deputies_flow/screens/deputies_list/deputies_list_screen.dart';

abstract class DeputiesDestination<SCREEN extends BaseScreen> extends Destination<SCREEN> {}

class DeputiesListDestination extends DeputiesDestination<DeputiesListScreen> {

  final DeputiesListModule _deputiesListModule;

  DeputiesListDestination._(this._deputiesListModule);

  factory DeputiesListDestination(BuildContext context) => DeputiesListDestination._(DeputiesListModule(context));

  @override
  DeputiesListScreen getScreen() => DeputiesListScreen();

  @override
  List<Module> getScreenModules(BuildContext context) => [_deputiesListModule];

  @override
  void dispose() {
    _deputiesListModule.disposeCache();
  }

}