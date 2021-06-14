import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/settings_flow/domain/settings/backer.dart';

abstract class GetBackersRepository {

  Future<Result<List<BackerModel>>> getBackers();

}