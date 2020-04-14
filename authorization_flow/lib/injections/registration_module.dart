import 'package:athens_core/injections/module.dart';
import 'package:authorization_flow/data/network/login_api.dart';
import 'package:authorization_flow/data/registration_repository_impl.dart';
import 'package:authorization_flow/domain/registration/registration_repository.dart';
import 'package:authorization_flow/domain/registration/registration_use_case.dart';
import 'package:authorization_flow/screens/registration/registration_bloc.dart';
import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

class RegistrationModule extends Module {

  RegistrationModule(BuildContext context) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    LoginApi loginApi = Provider.of<LoginApi>(context);
    RegistrationRepository repository = RegistrationRepositoryImpl(loginApi);
    RegistrationUseCase registrationUseCase = RegistrationUseCase(repository);
    return [
      Provider<RegistrationBloc>(
        create: (_) => RegistrationBloc(registrationUseCase),
        dispose: (_, bloc) => bloc.dispose(),
      )
    ];
  }

}