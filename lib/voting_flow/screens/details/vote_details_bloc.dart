import 'dart:async';

import 'package:project_athens/athens_core/models/voting_model.dart';
import 'package:project_athens/athens_core/navigation/bottom_navigation_bloc.dart';
import 'package:project_athens/athens_core/presentation/base_blocs/base_bloc.dart';
import 'package:project_athens/deputies_flow/navigation/deputies_destinations.dart';

class VoteDetailsBloc extends BaseBloc {

  final VotingModel _votingModel;

  VoteDetailsBloc(this._votingModel);

}