import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/more_flow/data/network/more_api.dart';
import 'package:project_athens/more_flow/domain/more/backer_model.dart';
import 'package:project_athens/more_flow/domain/more/get_backers_repository.dart';

class GetBackersRepositroyImpl extends GetBackersRepository {
  final MoreApi _moreApi;

  GetBackersRepositroyImpl(this._moreApi);

  Future<Result<List<BackerModel>>> getBackers() async {
    final response = await _moreApi.getBackers();

    final backers = response.backers
        .map((e) => BackerModel(e.nickname, e.amount, e.hasBadge, e.comment, e.backedAt, e.isCurrentUser))
        .toList();
    return Success(backers);
  }
}