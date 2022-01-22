import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/dashboard_flow/domain/dashboard_params.dart';

abstract class DashboardRepository {

  Future<Result> getDashboard(DashboardParams params);
}
