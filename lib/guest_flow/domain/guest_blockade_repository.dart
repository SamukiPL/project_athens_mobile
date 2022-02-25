import 'package:project_athens/athens_core/domain/result.dart';

abstract class GuestBlockadeRepository {
  Future<Result<void>> logoutGuest();
}