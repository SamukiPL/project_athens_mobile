import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:project_athens/athens_core/configuration/remote_configuration.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/athens_core/utils/firebase/firebase_deputy_subscriber.dart';
import 'package:project_athens/authorization_flow/data/network/login_api.dart';
import 'package:project_athens/authorization_flow/data/registration_repository_impl.dart';
import 'package:project_athens/authorization_flow/domain/registration/check_pair_usage_use_case.dart';
import 'package:project_athens/authorization_flow/domain/registration/registration_use_case.dart';
import 'package:project_athens/authorization_flow/screens/registration/registration_bloc.dart';
import 'package:project_athens/authorization_flow/screens/registration/stepper/registration_stepper_bloc.dart';
import 'package:project_athens/authorization_flow/screens/registration/stepper/stepper_button_state_bloc.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/account_info/account_info_form_key.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/account_info/account_info_step_bloc.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/account_info/show_repeat_email_notifier.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/deputies_chooser/deputies_chooser_step_bloc.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/deputies_chooser/step_search_bar_bloc.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/registration_end/registration_end_form_key.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/registration_end/registration_end_step_bloc.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/registration_end/show_repeat_password_notifier.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/registration_steps.dart';
import 'package:project_athens/deputies_utils/cache/deputies_cache.dart';
import 'package:project_athens/deputies_utils/data/network/deputies_api.dart';
import 'package:project_athens/deputies_utils/data/put_deputies_repository_impl.dart';
import 'package:project_athens/deputies_utils/domain/put_deputies/deputies_registration_use_case.dart';
import 'package:project_athens/main/firebase/firebase_messages.dart';
import 'package:provider/provider.dart';

class RegistrationModule extends Module {

  final RegistrationStep firstStep = RegistrationStep.ACCOUNT_INFO;

  RegistrationModule(BuildContext context) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    final loginApi = Provider.of<LoginApi>(context);
    final dio = Provider.of<Dio>(context);

    final deputiesApi = DeputiesApi(dio);

    final repository = RegistrationRepositoryImpl(loginApi);
    final registrationUseCase = RegistrationUseCase(repository);
    final checkPairUsageUseCase = CheckPairUsageUseCase(repository);
    final remoteConfig = Provider.of<RemoteConfiguration>(context);

    final headerBloc = RegistrationStepperBloc(firstStep);
    final buttonStateBloc = StepperButtonStateBloc();

    final repeatEmailNotifier = ShowRepeatEmailNotifier();
    final accountInfoStepBloc = AccountInfoStepBloc(checkPairUsageUseCase, repeatEmailNotifier);

    final repeatPasswordNotifier = ShowRepeatPasswordNotifier();
    final registrationEndStepBloc = RegistrationEndStepBloc(registrationUseCase, repeatPasswordNotifier, remoteConfig.cadence);

    final stepSearchBarBloc = StepSearchBarBloc();
    final deputiesChooserBloc = getDeputiesChooserBloc(context, loginApi, deputiesApi, stepSearchBarBloc, buttonStateBloc);

    return [
      Provider<RegistrationBloc>(
        create: (_) => RegistrationBloc(
            headerBloc,
            buttonStateBloc,
            accountInfoStepBloc,
            registrationEndStepBloc,
            deputiesChooserBloc
        ),
        dispose: (_, bloc) => bloc.dispose(),
      ),
      ChangeNotifierProvider<RegistrationStepperBloc>.value(
          value: headerBloc,
      ),
      ChangeNotifierProvider<StepperButtonStateBloc>.value(
          value: buttonStateBloc
      ),
      Provider<AccountInfoStepBloc>.value(
        value: accountInfoStepBloc,
      ),
      Provider<AccountInfoFormKey>(
        create: (_) => AccountInfoFormKey(),
      ),
      ChangeNotifierProvider<ShowRepeatEmailNotifier>.value(
          value: repeatEmailNotifier,
      ),
      Provider<RegistrationEndStepBloc>.value(
        value: registrationEndStepBloc,
      ),
      Provider<RegistrationEndFormKey>(
        create: (_) => RegistrationEndFormKey(),
      ),
      ChangeNotifierProvider<ShowRepeatPasswordNotifier>.value(
          value: repeatPasswordNotifier,
      ),
      Provider<DeputiesChooserBloc>.value(
        value: deputiesChooserBloc,
      ),
      ChangeNotifierProvider<StepSearchBarBloc>.value(
          value: stepSearchBarBloc
      )
    ];
  }

  DeputiesChooserBloc getDeputiesChooserBloc(
      BuildContext context,
      LoginApi loginApi,
      DeputiesApi deputiesApi,
      StepSearchBarBloc stepSearchBarBloc,
      StepperButtonStateBloc buttonStateBloc) {
    final firebaseMessaging = Provider.of<FirebaseMessages>(context);
    final deputiesCache = Provider.of<DeputiesCache>(context);

    final deputySubscriber = FirebaseDeputySubscriber(firebaseMessaging);

    final putDeputiesRepository = PutDeputiesRepositoryImpl(deputiesApi, deputySubscriber);
    final putDeputiesUseCase = PutDeputiesUseCase(putDeputiesRepository);

    return DeputiesChooserBloc(deputiesCache, putDeputiesUseCase, stepSearchBarBloc, buttonStateBloc);
  }

}