import 'package:project_athens/athens_core/domain/base_use_case.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/domain/base_repository.dart';
import 'package:project_athens/dashboard_flow/domain/parliament_meeting_details_params.dart';
import 'package:project_athens/dashboard_flow/domain/parliament_meeting_details_repository.dart';

class GetParliamentMeetingDetailsUseCase extends BaseUseCase {

  final ParliamentMeetingDetailsRepository repository;

  GetParliamentMeetingDetailsUseCase(this.repository);

  Future<Result> call(ParliamentMeetingDetailsParams params) {
    return repository.getParliamentMeetingDetails(
        params.cadence,
        params.parliamentMeetingId,
    ).safeApiCall();
  }
}
