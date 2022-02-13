import 'package:project_athens/athens_core/domain/base_use_case.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/timeline_flow/domain/timeline_parameters.dart';
import 'package:project_athens/timeline_flow/domain/timeline_repository.dart';
import 'package:project_athens/athens_core/domain/base_repository.dart';

class GetTimelineUseCase extends BaseUseCase {

  final TimelineRepository repository;

  GetTimelineUseCase(this.repository);

  Future<Result> call(TimelineParameters params) {
    return repository.getTimelineForDay(params.date).safeApiCall();
  }
}
