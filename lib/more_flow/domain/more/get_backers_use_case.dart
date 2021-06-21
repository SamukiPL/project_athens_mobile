import 'package:project_athens/athens_core/domain/base_repository.dart';
import 'package:project_athens/athens_core/domain/base_use_case.dart';
import 'package:project_athens/athens_core/domain/base_list/base_params.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/more_flow/domain/more/get_backers_repository.dart';

class GetBackersUseCase extends BaseUseCase<BaseParams> {

  final GetBackersRepository _getBackersRepository;

  GetBackersUseCase(this._getBackersRepository);

  @override
  Future<Result> call(BaseParams params) {
    return _getBackersRepository.getBackers();
  }
}