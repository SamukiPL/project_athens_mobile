import 'package:chopper/chopper.dart';

part 'deputies_api.chopper.dart';

@ChopperApi(baseUrl: "/deputy-aggregator/cadency-deputy/")
abstract class DeputiesApi extends ChopperService {

  static DeputiesApi create([ChopperClient client]) =>
      _$DeputiesApi(client);

  @Get(path: "get-all/{cadency}")
  Future<Response> getAllDeputies(@Path("cadency") int cadency);

}