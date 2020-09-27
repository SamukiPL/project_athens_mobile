import 'package:project_athens/athens_core/domain/result.dart';

abstract class LogoutRepository {

  Future<Result<bool>> logout();

}