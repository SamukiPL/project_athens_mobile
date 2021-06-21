import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/domain/base_repository.dart';

abstract class LogoutRepository {

  Future<Result<bool>> logout();

}