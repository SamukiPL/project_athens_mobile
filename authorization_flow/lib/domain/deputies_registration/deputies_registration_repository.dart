import 'package:athens_core/domain/result.dart';
import 'package:authorization_flow/domain/deputies_registration/deputies_registration_params.dart';
import 'package:authorization_flow/domain/deputies_registration/deputy_model.dart';
import 'package:authorization_flow/domain/deputies_registration/put_deputy_model.dart';


abstract class DeputiesRegistrationRepository {

 Future<Result> getDeputies(DeputiesRegistrationParams params);

 Future<Result> putDeputies(DeputiesRegistrationParams params, List<PutDeputyModel> models);

}