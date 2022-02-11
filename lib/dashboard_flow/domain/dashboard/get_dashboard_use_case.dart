import 'package:project_athens/athens_core/domain/base_use_case.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/dashboard_flow/domain/dashboard_params.dart';
import 'package:project_athens/dashboard_flow/domain/dashboard_repository.dart';
import 'package:project_athens/athens_core/domain/base_repository.dart';

class GetDashboardUseCase extends BaseUseCase {

  final DashboardRepository repository;

  GetDashboardUseCase(this.repository);

  Future<Result> call(DashboardParams params) {
    return repository.getDashboard(params).safeApiCall();
  }
}
