import 'package:athens_core/domain/result.dart';
import 'result.dart';

abstract class BaseUseCase<PARAMS> {

  Future<Result> call(PARAMS params);

}