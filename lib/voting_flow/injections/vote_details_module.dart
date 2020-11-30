import 'package:flutter/src/widgets/framework.dart';
import 'package:nested/nested.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/athens_core/models/timeline_model.dart';
import 'package:project_athens/athens_core/models/voting_model.dart';
import 'package:project_athens/voting_flow/screens/details/vote_details_bloc.dart';
import 'package:provider/provider.dart';

class VoteDetailsModule extends Module {

  final VotingModel _votingModel;

  VoteDetailsModule(BuildContext context, this._votingModel) : super(context);

  @override
  List<SingleChildWidget> getProviders() {

    return [
      Provider<VoteDetailsBloc>(
        create: (_) => VoteDetailsBloc(_votingModel),
        dispose: (_, bloc) => bloc.dispose(),
      )
    ];
  }

}