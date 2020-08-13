import 'package:chopper/chopper.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/athens_core/utils/firebase/firebase_deputy_subscriber.dart';
import 'package:project_athens/authorization_flow/data/network/login_api.dart';
import 'package:project_athens/authorization_flow/data/registration_repository_impl.dart';
import 'package:project_athens/authorization_flow/domain/registration/check_pair_usage_use_case.dart';
import 'package:project_athens/authorization_flow/domain/registration/registration_repository.dart';
import 'package:project_athens/authorization_flow/domain/registration/registration_use_case.dart';
import 'package:project_athens/authorization_flow/screens/registration/registration_bloc.dart';
import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:project_athens/authorization_flow/screens/registration/stepper/registration_stepper_bloc.dart';
import 'package:project_athens/authorization_flow/screens/registration/stepper/stepper_button_state_bloc.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/account_info/account_info_form_key.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/account_info/account_info_step_bloc.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/deputies_chooser/deputies_chooser_step_bloc.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/registration_end/registration_end_form_key.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/registration_end/registration_end_step_bloc.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/registration_end/show_repeat_password_notifier.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/registration_steps.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/account_info/show_repeat_email_notifier.dart';
import 'package:project_athens/deputies_utils/data/get_deputies_repository_impl.dart';
import 'package:project_athens/deputies_utils/data/network/deputies_api.dart';
import 'package:project_athens/deputies_utils/data/put_deputies_repository_impl.dart';
import 'package:project_athens/deputies_utils/domain/get_deputies/get_deputies_use_case.dart';
import 'package:project_athens/deputies_utils/domain/put_deputies/deputies_registration_use_case.dart';
import 'package:project_athens/main/firebase/firebase_messages.dart';
import 'package:provider/provider.dart';

class RegistrationModule extends Module {

  final RegistrationStep firstStep = RegistrationStep.ACCOUNT_INFO;

  RegistrationModule(BuildContext context) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    final loginApi = Provider.of<LoginApi>(context);
    final chopperClient = Provider.of<ChopperClient>(context);
    final deputiesApi = DeputiesApi.create(chopperClient);

    final repository = RegistrationRepositoryImpl(loginApi);
    final registrationUseCase = RegistrationUseCase(repository);
    final checkPairUsageUseCase = CheckPairUsageUseCase(repository);

    final headerBloc = RegistrationStepperBloc(firstStep);
    final buttonStateBloc = StepperButtonStateBloc();

    final repeatEmailNotifier = ShowRepeatEmailNotifier();
    final accountInfoStepBloc = AccountInfoStepBloc(checkPairUsageUseCase, repeatEmailNotifier);

    final repeatPasswordNotifier = ShowRepeatPasswordNotifier();
    final registrationEndStepBloc = RegistrationEndStepBloc(registrationUseCase, repeatPasswordNotifier);

    final deputiesChooserBloc = getDeputiesChooserBloc(context, loginApi, deputiesApi);

    return [
      Provider<RegistrationBloc>(
        create: (_) => RegistrationBloc(headerBloc, buttonStateBloc, accountInfoStepBloc, registrationEndStepBloc, deputiesChooserBloc),
        dispose: (_, bloc) {
          bloc.dispose();
          deputiesApi.dispose();
        },
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
      )
    ];
  }

  DeputiesChooserBloc getDeputiesChooserBloc(BuildContext context, LoginApi loginApi, DeputiesApi deputiesApi) {
    final firebaseMessaging = Provider.of<FirebaseMessages>(context);

    final deputySubscriber = FirebaseDeputySubscriber(firebaseMessaging);

    final getDeputiesRepository = GetDeputiesRepositoryImpl(loginApi);
    final getDeputiesUseCase = GetDeputiesUseCase(getDeputiesRepository);

    final putDeputiesRepository = PutDeputiesRepositoryImpl(deputiesApi, deputySubscriber);
    final putDeputiesUseCase = PutDeputiesUseCase(putDeputiesRepository);

    return DeputiesChooserBloc(getDeputiesUseCase, putDeputiesUseCase);
  }

}