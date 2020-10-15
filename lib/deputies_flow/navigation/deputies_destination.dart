import 'package:flutter/src/widgets/framework.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/athens_core/navigation/destination_manager.dart';
import 'package:project_athens/athens_core/presentation/base_screen.dart';
import 'package:project_athens/deputies_flow/injections/deputies_list_module.dart';
import 'package:project_athens/deputies_flow/injections/deputy_details_module.dart';
import 'package:project_athens/deputies_flow/screens/details/deputy_details_screen.dart';
import 'package:project_athens/deputies_flow/screens/list/deputies_list_screen.dart';
import 'package:project_athens/deputies_utils/domain/deputy_model.dart';

abstract class DeputiesDestination<SCREEN extends BaseScreen>
    extends Destination<SCREEN> {}

class DeputiesListDestination extends DeputiesDestination<DeputiesListScreen> {

  @override
  DeputiesListScreen getScreen() => DeputiesListScreen();

  @override
  List<Module> getScreenModules(BuildContext context) => [DeputiesListModule(context)];
}

class DeputyDetailsDestination
    extends DeputiesDestination<DeputyDetailsScreen> {
  final DeputyModel _deputyModel;

  DeputyDetailsDestination(this._deputyModel);

  @override
  DeputyDetailsScreen getScreen() => DeputyDetailsScreen(_deputyModel);

  @override
  List<Module> getScreenModules(BuildContext context) =>
      [DeputyDetailsModule(context, _deputyModel)];
}
