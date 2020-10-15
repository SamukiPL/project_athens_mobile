import 'package:project_athens/deputies_utils/data/network/request/put_deputies_request.dart';
import 'package:chopper/chopper.dart';

part 'deputies_api.chopper.dart';

@ChopperApi()
abstract class DeputiesApi extends ChopperService {

  static DeputiesApi create([ChopperClient client]) =>
      _$DeputiesApi(client);

  @Get(path: "/deputy-aggregator/cadency-deputy/get-all/{cadency}")
  Future<Response> getAllDeputies(@Path("cadency") int cadency);

  @Put(path: "/user-aggregator/deputy-subscribe/{cadency}")
  Future<Response> putDeputies(@Path("cadency") int cadency, @body PutDeputiesRequest request);

  @Get(path: "/user-aggregator/deputy-subscribe/{cadency}")
  Future<Response> getSubscribedDeputies(@Path("cadency") int cadency);

}