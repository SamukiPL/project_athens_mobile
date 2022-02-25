import 'package:project_athens/athens_core/domain/base_use_case.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/guest_flow/domain/guest_blockade_repository.dart';

class LogoutGuestUseCase extends BaseUseCase {
  final GuestBlockadeRepository _repository;

  LogoutGuestUseCase(this._repository);

  Future<Result> call() {
    return _repository.logoutGuest();
  }
}