import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/more_flow/domain/more/backer_model.dart';

abstract class GetBackersRepository {

  Future<Result<List<BackerModel>>> getBackers();

}