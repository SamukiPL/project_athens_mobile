import 'package:project_athens/athens_core/domain/result.dart';

abstract class ParliamentMeetingDetailsRepository {

  Future<Result> getParliamentMeetingDetails(
      int cadence,
      String parliamentMeetingId,
      );
}
