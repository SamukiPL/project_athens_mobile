import 'package:project_athens/athens_core/domain/result.dart';
import 'result.dart';

abstract class BaseUseCase<PARAMS> {

  Future<Result> call(PARAMS params);

}