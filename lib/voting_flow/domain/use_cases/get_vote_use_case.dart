import 'package:project_athens/athens_core/data/base_responses/voting_response.dart';
import 'package:project_athens/athens_core/domain/base_use_case.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/models/voting_model.dart';
import 'package:project_athens/voting_flow/domain/get_vote_parameters.dart';
import 'package:project_athens/voting_flow/domain/vote_repository.dart';
import 'package:project_athens/athens_core/domain/base_repository.dart';

class GetVoteUseCase extends BaseUseCase<GetVoteParameters> {

  final VoteRepository repository;

  GetVoteUseCase(this.repository);

  @override
  Future<Result<VotingModel>> call(GetVoteParameters params) => repository.getVoteById(params.voteId).safeApiCall();

}