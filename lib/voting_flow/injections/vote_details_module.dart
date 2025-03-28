import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:project_athens/athens_core/data/item_was_seen/seen_item_data_source.dart';
import 'package:project_athens/athens_core/data/vote/vote_slim_model.dart';
import 'package:project_athens/athens_core/domain/item_was_seen/vote_was_seen_use_case.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/deputies_utils/cache/parliament_clubs_cache.dart';
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
    final clubsCache = Provider.of<ParliamentClubsCache>(context);

    final VotingNetworkMapper _votingNetworkMapper = VotingNetworkMapper(localizations as AppLocalizations);
    final VoteRepositoryImpl repository = VoteRepositoryImpl(votingApi, _votingNetworkMapper);
    final GetVoteUseCase useCase = GetVoteUseCase(repository);

    final seenDataSource = Provider.of<SeenItemDataSource>(context);
    final voteWasSeenUseCase = VoteWasSeenUseCase(seenDataSource);

    return [
      Provider<VoteDetailsBloc>(
        create: (_) => VoteDetailsBloc(_voteModel, useCase, clubsCache, voteWasSeenUseCase),
        dispose: (_, bloc) => bloc.dispose(),
      )
    ];
  }
}
