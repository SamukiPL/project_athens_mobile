import 'package:chopper/chopper.dart';

part 'timeline_api.chopper.dart';

@ChopperApi(baseUrl: "/user-aggregator/timeline")
abstract class TimelineApi extends ChopperService {
  static TimelineApi create([ChopperClient client]) => _$TimelineApi(client);

  @Get(path: "/{cadency}/parliament-meetings")
  Future<Response> getMeetingsDates(
      @Path("cadency") int cadency);

  @Get(path: "/{cadency}/{date}")
  Future<Response> getAllDeputies(
      @Path("cadency") int cadency, @Path("date") String date);
}
