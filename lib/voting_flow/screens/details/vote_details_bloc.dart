import 'dart:async';

import 'package:project_athens/athens_core/data/vote/vote_slim_model.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/models/voting_model.dart';
import 'package:project_athens/athens_core/presentation/base_blocs/base_bloc.dart';
import 'package:project_athens/deputies_utils/cache/deputies_cache.dart';
import 'package:project_athens/deputies_utils/domain/parliament_club_model.dart';
import 'package:project_athens/voting_flow/domain/get_vote_parameters.dart';
import 'package:project_athens/voting_flow/domain/use_cases/get_vote_use_case.dart';
import 'package:project_athens/voting_flow/screens/details/vote_club_distribution_row_data.dart';
import 'package:rxdart/rxdart.dart';

class VoteDetailsBloc extends BaseBloc {

  final VoteSlimModel _voteModel;
  final GetVoteUseCase _getVoteUseCase;
  final DeputiesCache _deputiesCache;

  VoteDetailsBloc(this._voteModel, this._getVoteUseCase, this._deputiesCache) {
    final params = GetVoteParameters(this._voteModel.id);
    _getVoteUseCase(params).then((value) {
      if (value is Success<VotingModel>) {
        votingFullStream.add(value.value);
      }
    });
  }

  final ReplaySubject<VotingModel> votingFullStream = ReplaySubject<VotingModel>();
  Stream<List<VoteClubDistributionRowData>> get clubVoteDistribution => votingFullStream.withLatestFrom(Stream.fromFuture(_deputiesCache.parliamentClubs), (t, s) {
    if (s is Success<List<ParliamentClubModel>>) {
      return t.clubVotes.map((e) => VoteClubDistributionRowData(e, s.value.firstWhere((element) => element.id == e.parliamentClub))).toList();
    } else {
      return List.empty() as List<VoteClubDistributionRowData>;
    }
  });

  @override
  dispose() {
    votingFullStream.close();
  }
}
