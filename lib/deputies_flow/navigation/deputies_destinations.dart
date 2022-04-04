import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/athens_core/navigation/bottom_navigation_bloc.dart';
import 'package:project_athens/athens_core/navigation/destination_manager.dart';
import 'package:project_athens/deputies_flow/domain/vote_accuracy_alignment_enum.dart';
import 'package:project_athens/deputies_flow/injections/deputies_list_module.dart';
import 'package:project_athens/deputies_flow/injections/deputy_details_module.dart';
import 'package:project_athens/deputies_flow/injections/deputy_speeches_list_module.dart';
import 'package:project_athens/deputies_flow/injections/deputy_vote_accuracy_module.dart';
import 'package:project_athens/deputies_flow/injections/deputy_votes_list_module.dart';
import 'package:project_athens/deputies_flow/injections/details_tabs/deputy_information_module.dart';
import 'package:project_athens/deputies_flow/screens/details/deputy_details_screen.dart';
import 'package:project_athens/deputies_flow/screens/list/deputies_list_screen.dart';
import 'package:project_athens/deputies_flow/screens/speeches_list/deputy_speeches_list_screen.dart';
import 'package:project_athens/deputies_flow/screens/vote_accuracy/deputy_vote_accuracy_screen.dart';
import 'package:project_athens/deputies_flow/screens/votes_list/deputy_votes_list_screen.dart';
import 'package:project_athens/deputies_utils/domain/deputy_full.dart';
import 'package:project_athens/deputies_utils/domain/deputy_model.dart';
import 'package:project_athens/deputies_utils/domain/subscribed_deputy_model.dart';

class DeputiesListDestination extends Destination<DeputiesListScreen> {
  DeputiesListDestination() : super(BottomNavItem.DEPUTIES);

  @override
  DeputiesListScreen getScreen() => DeputiesListScreen();

  @override
  List<Module> getScreenModules(BuildContext context) => [DeputiesListModule(context)];

  @override
  bool operator ==(Object other) => other is DeputiesListDestination;

  @override
  int get hashCode => super.hashCode;
}

class DeputyDetailsDestination extends Destination<DeputyDetailsScreen> {
  final SubscribedDeputyModel _deputyModel;

  DeputyDetailsDestination(this._deputyModel) : super(BottomNavItem.DEPUTIES);

  @override
  DeputyDetailsScreen getScreen() => DeputyDetailsScreen(_deputyModel);

  @override
  List<Module> getScreenModules(BuildContext context) => [
        DeputyDetailsModule(context, _deputyModel),
        DeputyInformationModule(context, _deputyModel.id),
      ];

  @override
  bool operator ==(Object other) => other is DeputyDetailsDestination && other._deputyModel == _deputyModel;

  @override
  int get hashCode => Object.hashAll([_deputyModel]);
}

class DeputyDetailsVoteAccuracyDestination extends Destination<DeputyVoteAccuracyScreen> {
  final ClubVoteAccuracy _clubVoteAccuracy;
  final DeputyModel _deputy;
  final VoteAccuracyAlignment _alignment;

  DeputyDetailsVoteAccuracyDestination(this._clubVoteAccuracy, this._deputy, this._alignment)
      : super(BottomNavItem.DEPUTIES);

  @override
  DeputyVoteAccuracyScreen getScreen() => DeputyVoteAccuracyScreen(_alignment);

  @override
  List<Module> getScreenModules(BuildContext context) => [
        DeputyDetailsModule(context, _deputy as SubscribedDeputyModel),
        DeputyVoteAccuracyModule(context, _deputy as SubscribedDeputyModel, this._alignment, this._clubVoteAccuracy)
      ];

  @override
  bool operator ==(Object other) =>
      other is DeputyDetailsVoteAccuracyDestination &&
      other._clubVoteAccuracy == _clubVoteAccuracy &&
      other._deputy == _deputy &&
      _alignment == _alignment;

  @override
  int get hashCode => Object.hashAll([_clubVoteAccuracy, _deputy, _alignment]);
}

class DeputySpeechesListDestination extends Destination<DeputySpeechesListScreen> {
  final SubscribedDeputyModel _deputyModel;

  DeputySpeechesListDestination(this._deputyModel) : super(BottomNavItem.DEPUTIES);

  @override
  DeputySpeechesListScreen getScreen() => DeputySpeechesListScreen();

  @override
  List<Module> getScreenModules(BuildContext context) => [DeputySpeechesListModule(context, _deputyModel.id)];

  @override
  bool operator ==(Object other) => other is DeputySpeechesListDestination;

  @override
  int get hashCode => Object.hashAll([_deputyModel]);
}

class DeputyVotesListDestination extends Destination<DeputyVotesListScreen> {
  final SubscribedDeputyModel _deputyModel;

  DeputyVotesListDestination(this._deputyModel) : super(BottomNavItem.DEPUTIES);

  @override
  DeputyVotesListScreen getScreen() => DeputyVotesListScreen();

  @override
  List<Module> getScreenModules(BuildContext context) => [DeputyVotesListModule(context, _deputyModel.id)];

  @override
  bool operator ==(Object other) => other is DeputyVotesListDestination;

  @override
  int get hashCode => Object.hashAll([_deputyModel]);
}
