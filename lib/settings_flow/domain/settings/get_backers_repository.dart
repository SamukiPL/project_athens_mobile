import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/settings_flow/data/network/response/get_backers_response.dart';

abstract class GetBackersRepository {

  Future<Result<GetBackersResponse>> getBackers();

}