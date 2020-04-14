import 'package:athens_core/domain/result.dart';
import 'package:authorization_flow/domain/registration/registration_params.dart';

abstract class RegistrationRepository {

  Future<Result> register(RegistrationParams params);

}