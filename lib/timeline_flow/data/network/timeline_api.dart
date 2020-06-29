import 'package:chopper/chopper.dart';

part 'timeline_api.chopper.dart';

@ChopperApi()
abstract class TimelineApi extends ChopperService {
  static TimelineApi create([ChopperClient client]) => _$TimelineApi(client);

  @Get(path: "/user-aggregator/timeline/{cadency}/parliament-meetings")
  Future<Response> getMeetingsDates(
      @Path("cadency") int cadency);

  @Get(path: "/user-aggregator/timeline/{cadency}/{date}")
  Future<Response> getAllDeputies(
      @Path("cadency") int cadency, @Path("date") String date);
}
