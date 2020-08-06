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
import 'package:project_athens/authorization_flow/screens/registration/steps/registration_end/registration_end_step_bloc.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/registration_end/show_repeat_password_notifier.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/registration_steps.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/account_info/show_repeat_email_notifier.dart';
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

    ShowRepeatEmailNotifier repeatEmailNotifier = ShowRepeatEmailNotifier();
    AccountInfoStepBloc accountInfoStepBloc = AccountInfoStepBloc(checkPairUsageUseCase, repeatEmailNotifier);

    ShowRepeatPasswordNotifier repeatPasswordNotifier = ShowRepeatPasswordNotifier();
    RegistrationEndStepBloc registrationEndStepBloc = RegistrationEndStepBloc(registrationUseCase, repeatPasswordNotifier);

    return [
      Provider<RegistrationBloc>(
        create: (_) => RegistrationBloc(headerBloc, accountInfoStepBloc, registrationEndStepBloc),
        dispose: (_, bloc) => bloc.dispose(),
      ),
      ChangeNotifierProvider<RegistrationStepperBloc>.value(
          value: headerBloc,
      ),
      Provider<AccountInfoStepBloc>.value(
        value: accountInfoStepBloc,
      ),
      ChangeNotifierProvider<ShowRepeatEmailNotifier>.value(
          value: repeatEmailNotifier,
      ),
      Provider<RegistrationEndStepBloc>.value(
        value: registrationEndStepBloc,
      ),
      ChangeNotifierProvider<ShowRepeatPasswordNotifier>.value(
          value: repeatPasswordNotifier,
      ),
    ];
  }

}