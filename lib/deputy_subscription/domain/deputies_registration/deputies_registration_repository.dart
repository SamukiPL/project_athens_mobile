import 'package:project_athens/athens_core/domain/result.dart';

import 'package:project_athens/deputy_subscription/domain/deputies_registration/deputy_model.dart';
import 'package:project_athens/deputy_subscription/domain/deputies_registration/deputies_registration_params.dart';


abstract class DeputiesRegistrationRepository {

 Future<Result<List<DeputyModel>>> getDeputies(DeputiesRegistrationParams params);

}