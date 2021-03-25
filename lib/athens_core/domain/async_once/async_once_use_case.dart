
import 'package:project_athens/athens_core/domain/result.dart';

abstract class AsyncOnceUseCase<T> {

  Future<Result<T>> call();

}