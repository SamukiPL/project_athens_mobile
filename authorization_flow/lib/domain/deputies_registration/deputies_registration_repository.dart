import 'package:athens_core/domain/result.dart';
import 'package:authorization_flow/domain/deputies_registration/deputies_registration_params.dart';


abstract class DeputiesRegistrationRepository {

 Future<Result> getDeputies(DeputiesRegistrationParams params);

}