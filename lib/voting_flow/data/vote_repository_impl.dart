import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/models/voting_model.dart';
import 'package:project_athens/voting_flow/data/network/voting_api.dart';
import 'package:project_athens/voting_flow/domain/vote_repository.dart';
import 'package:project_athens/voting_flow/mappers/voting_network_mapper.dart';

class VoteRepositoryImpl implements VoteRepository {
  final VotingApi _votingApi;

  final VotingNetworkMapper _votingNetworkMapper;

  VoteRepositoryImpl(this._votingApi, this._votingNetworkMapper);

  Future<Result<VotingModel>> getVoteById(String voteId) async {
    final voting = await _votingApi.getVotingLiteById(voteId);

    final voteModel = await _votingNetworkMapper.transform(voting);

    return Success(voteModel);
  }
}
