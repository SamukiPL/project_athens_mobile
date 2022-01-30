import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/dashboard_flow/data/network/dashboard_api.dart';
import 'package:project_athens/dashboard_flow/domain/parliament_meeting_details_repository.dart';
import 'package:project_athens/dashboard_flow/domain/parliament_meeting_model.dart';
import 'package:project_athens/dashboard_flow/mappers/parliament_meeting_details_network_mapper.dart';

class ParliamentMeetingDetailsRepositoryImpl implements ParliamentMeetingDetailsRepository {
  final DashboardApi dashboardApi;
  final ParliamentMeetingNetworkMapper networkMapper;

  ParliamentMeetingDetailsRepositoryImpl(this.dashboardApi, this.networkMapper);

  @override
  Future<Result<ParliamentMeetingModel>> getParliamentMeetingDetails(
      int cadence,
      String parliamentMeetingId,
      ) async {
    final response = await dashboardApi.getParliamentMeetingDetails(
        cadence, parliamentMeetingId
    );

    final ParliamentMeetingModel model = networkMapper.transform(response);

    return Success(model);
  }
}
