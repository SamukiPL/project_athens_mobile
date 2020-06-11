import 'package:chopper/chopper.dart';

part 'deputies_api.chopper.dart';

@ChopperApi(baseUrl: "/deputy-aggregator/cadency-deputy/")
abstract class DeputiesApi extends ChopperService {

  @Get(path: "get-all/{cadency}")
  Future<Response> getAllDeputies(@Path("cadency") int cadency);

}