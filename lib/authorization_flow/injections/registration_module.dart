import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/authorization_flow/data/network/login_api.dart';
import 'package:project_athens/authorization_flow/data/registration_repository_impl.dart';
import 'package:project_athens/authorization_flow/domain/registration/check_pair_usage_use_case.dart';
import 'package:project_athens/authorization_flow/domain/registration/registration_repository.dart';
import 'package:project_athens/authorization_flow/domain/registration/registration_use_case.dart';
import 'package:project_athens/authorization_flow/screens/registration/registration_bloc.dart';
import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:project_athens/authorization_flow/screens/registration/stepper/registration_stepper_bloc.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/account_info/account_info_step_bloc.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/registration_steps.dart';
import 'package:provider/provider.dart';

class RegistrationModule extends Module {

  final RegistrationStep firstStep = RegistrationStep.ACCOUNT_INFO;

  RegistrationModule(BuildContext context) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    LoginApi loginApi = Provider.of<LoginApi>(context);
    RegistrationRepository repository = RegistrationRepositoryImpl(loginApi);
    RegistrationUseCase registrationUseCase = RegistrationUseCase(repository);
    CheckPairUsageUseCase checkPairUsageUseCase = CheckPairUsageUseCase(repository);

    RegistrationStepperBloc headerBloc = RegistrationStepperBloc(firstStep);

    AccountInfoStepBloc accountInfoStepBloc = AccountInfoStepBloc(checkPairUsageUseCase);

    return [
      Provider<RegistrationBloc>(
        create: (_) => RegistrationBloc(headerBloc, accountInfoStepBloc),
        dispose: (_, bloc) => bloc.dispose(),
      ),
      ChangeNotifierProvider<RegistrationStepperBloc>.value(
          value: headerBloc,
      ),
      ChangeNotifierProvider<AccountInfoStepBloc>.value(
          value: accountInfoStepBloc,
      ),
    ];
  }

}