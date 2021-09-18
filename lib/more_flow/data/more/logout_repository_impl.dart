import 'package:project_athens/athens_core/auth/auth_storage.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/more_flow/data/network/more_api.dart';
import 'package:project_athens/more_flow/domain/more/logout_repository.dart';
import 'package:project_athens/athens_core/domain/base_repository.dart';

class LogoutRepositoryImpl extends LogoutRepository {

  final MoreApi _moreApi;

  final AuthStorage storage = AuthStorage();

  LogoutRepositoryImpl(this._moreApi);

  @override
  Future<Result<bool>> logout() async {
    await storage.removeTokens();
    await _moreApi.logout();
    return Success(true);
  }

}