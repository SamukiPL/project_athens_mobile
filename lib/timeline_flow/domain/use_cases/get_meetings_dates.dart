import 'package:project_athens/athens_core/domain/base_use_case.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/domain/base_repository.dart';
import 'package:project_athens/timeline_flow/domain/timeline_parameters.dart';
import 'package:project_athens/timeline_flow/domain/timeline_repository.dart';

class GetMeetingsDates extends BaseUseCase {

  final TimelineRepository repository;

  GetMeetingsDates(this.repository);

  Future<Result> call(TimelineParameters params) {
    return repository.getMeetingsDates().safeApiCall();
  }
}
