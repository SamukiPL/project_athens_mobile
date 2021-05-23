import 'package:flutter/src/widgets/framework.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/athens_core/navigation/bottom_navigation_bloc.dart';
import 'package:project_athens/athens_core/navigation/destination_manager.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/deputies_chooser/list/deputy_item_view_model.dart';
import 'package:project_athens/deputies_flow/injections/deputies_list_module.dart';
import 'package:project_athens/deputies_flow/injections/deputy_details_module.dart';
import 'package:project_athens/deputies_flow/injections/details_tabs/deputy_information_module.dart';
import 'package:project_athens/deputies_flow/injections/details_tabs/deputy_speeches_module.dart';
import 'package:project_athens/deputies_flow/injections/details_tabs/deputy_votings_module.dart';
import 'package:project_athens/deputies_flow/screens/details/deputy_details_screen.dart';
import 'package:project_athens/deputies_flow/screens/list/deputies_list_screen.dart';
import 'package:project_athens/deputies_utils/domain/deputy_model.dart';
import 'package:project_athens/deputies_utils/domain/subscribed_deputy_model.dart';

class DeputiesListDestination extends Destination<DeputiesListScreen> {

  DeputiesListDestination(): super(BottomNavItem.DEPUTIES);

  @override
  DeputiesListScreen getScreen() =>
      DeputiesListScreen();

  @override
  List<Module> getScreenModules(BuildContext context) =>
      [DeputiesListModule(context)];
}

class DeputyDetailsDestination extends Destination<DeputyDetailsScreen> {
  final SubscribedDeputyModel _deputyModel;

  DeputyDetailsDestination(this._deputyModel): super(BottomNavItem.DEPUTIES);

  @override
  DeputyDetailsScreen getScreen() =>
      DeputyDetailsScreen(_deputyModel);

  @override
  List<Module> getScreenModules(BuildContext context) => [
        DeputyDetailsModule(context, _deputyModel),
    DeputyInformationModule(context, _deputyModel.id),
    DeputySpeechesModule(context, _deputyModel.id),
    DeputyVotingsModule(context, _deputyModel.id),
      ];
}
