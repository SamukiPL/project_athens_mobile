import 'dart:async';

import 'package:project_athens/athens_core/data/vote/vote_slim_model.dart';
import 'package:project_athens/athens_core/domain/item_was_seen/vote_was_seen_use_case.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/models/voting_model.dart';
import 'package:project_athens/athens_core/presentation/base_blocs/base_bloc.dart';
import 'package:project_athens/deputies_utils/cache/parliament_clubs_cache.dart';
import 'package:project_athens/deputies_utils/domain/parliament_club_model.dart';
import 'package:project_athens/voting_flow/domain/get_vote_parameters.dart';
import 'package:project_athens/voting_flow/domain/use_cases/get_vote_use_case.dart';
import 'package:project_athens/voting_flow/screens/details/vote_club_distribution_row_data.dart';
import 'package:rxdart/rxdart.dart';

class VoteDetailsBloc extends BaseBloc {

  final VoteSlimModel _voteModel;
  final GetVoteUseCase _getVoteUseCase;
  final ParliamentClubsCache _clubsCache;
  final VoteWasSeenUseCase _voteWasSeenUseCase;

  VoteDetailsBloc(this._voteModel, this._getVoteUseCase, this._clubsCache, this._voteWasSeenUseCase) {
    final params = GetVoteParameters(this._voteModel.id);
    _getVoteUseCase(params).then((value) {
      if (value is Success<VotingModel>) {
        votingFullStream.add(value.value);
        _voteWasSeenUseCase(value.value.id);
      }
    });
  }

  final ReplaySubject<VotingModel> votingFullStream = ReplaySubject<VotingModel>();
  Stream<List<VoteClubDistributionRowData>> get clubVoteDistribution => votingFullStream.withLatestFrom(Stream.fromFuture(_clubsCache.parliamentClubs), (voteFull, parliamentClubs) {
    if (parliamentClubs is Success<List<ParliamentClubModel>>) {
      return voteFull.clubVotes.map((clubVote) =>
        VoteClubDistributionRowData(
          clubVote,
          parliamentClubs.value.firstWhere((element) => element.id == clubVote.parliamentClub))
      ).toList();
    } else {
      return List.empty() as List<VoteClubDistributionRowData>;
    }
  });

  @override
  dispose() {
    votingFullStream.close();
  }
}
