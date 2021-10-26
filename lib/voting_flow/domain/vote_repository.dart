import 'package:project_athens/athens_core/models/voting_model.dart';
import 'package:project_athens/athens_core/domain/result.dart';

abstract class VoteRepository {
  Future<Result<VotingModel>> getVoteById(String voteId);
}