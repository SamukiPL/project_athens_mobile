import 'package:dio/dio.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nested/nested.dart';
import 'package:project_athens/athens_core/data/vote/vote_slim_model.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/athens_core/models/timeline_model.dart';
import 'package:project_athens/athens_core/models/voting_model.dart';
import 'package:project_athens/voting_flow/data/network/voting_api.dart';
import 'package:project_athens/voting_flow/data/vote_repository_impl.dart';
import 'package:project_athens/voting_flow/domain/use_cases/get_vote_use_case.dart';
import 'package:project_athens/voting_flow/mappers/voting_network_mapper.dart';
import 'package:project_athens/voting_flow/screens/details/vote_details_bloc.dart';
import 'package:provider/provider.dart';

class VoteDetailsModule extends Module {

  final VoteSlimModel _voteModel;

  VoteDetailsModule(BuildContext context, this._voteModel) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    final dio = Provider.of<Dio>(context);
    final votingApi = VotingApi(dio);
    final localizations = AppLocalizations.of(context);


    final VotingNetworkMapper _votingNetworkMapper = VotingNetworkMapper(localizations);
    final VoteRepositoryImpl repository = VoteRepositoryImpl(votingApi, _votingNetworkMapper);
    final GetVoteUseCase useCase = GetVoteUseCase(repository);

    return [
      Provider<VoteDetailsBloc>(
        create: (_) => VoteDetailsBloc(_voteModel, useCase),
        dispose: (_, bloc) => bloc.dispose(),
      )
    ];
  }

}