import 'package:project_athens/athens_core/auth/auth_storage.dart';
import 'package:project_athens/athens_core/chopper/auth_facade.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/guest_flow/domain/guest_blockade_repository.dart';

class GuestBlockadeRepositoryImpl extends GuestBlockadeRepository {
  final AuthStorage _authStorage = AuthStorage();
  final AuthFacade _authFacade;

  GuestBlockadeRepositoryImpl(this._authFacade);

  @override
  Future<Result<void>> logoutGuest() async {
    try {
      await _authStorage.removeTokens();
      _authFacade.clearTokens();
      return Success({});
    } catch (e) {
      return Failure(e);
    }
  }
}