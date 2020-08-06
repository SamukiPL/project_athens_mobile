import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/athens_core/utils/firebase/firebase_deputy_subscriber.dart';
import 'package:project_athens/authorization_flow/data/network/login_api.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/deputies_chooser/deputies_chooser_step_bloc.dart';
import 'package:project_athens/deputies_utils/data/get_deputies_repository_impl.dart';
import 'package:project_athens/deputies_utils/data/network/deputies_api.dart';
import 'package:project_athens/deputies_utils/data/put_deputies_repository_impl.dart';
import 'package:project_athens/deputies_utils/domain/get_deputies/get_deputies_use_case.dart';
import 'package:project_athens/deputies_utils/domain/put_deputies/deputies_registration_use_case.dart';
import 'package:project_athens/main/firebase/firebase_messages.dart';
import 'package:provider/provider.dart';

class DeputiesRegistrationModule extends Module {
  DeputiesRegistrationModule(BuildContext context) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    final loginApi = Provider.of<LoginApi>(context);
    final chopperClient = Provider.of<ChopperClient>(context);
    final firebaseMessaging = Provider.of<FirebaseMessages>(context);

    final deputiesApi = DeputiesApi.create(chopperClient);
    final deputySubscriber = FirebaseDeputySubscriber(firebaseMessaging);

    final getDeputiesRepository = GetDeputiesRepositoryImpl(loginApi);
    final getDeputiesUseCase = GetDeputiesUseCase(getDeputiesRepository);

    final putDeputiesRepository = PutDeputiesRepositoryImpl(deputiesApi, deputySubscriber);
    final putDeputiesUseCase = PutDeputiesUseCase(putDeputiesRepository);
    return [
      Provider<DeputiesRegistrationBloc>(
        create: (_) =>
            DeputiesRegistrationBloc(getDeputiesUseCase, putDeputiesUseCase),
        dispose: (context, bloc) {
          bloc.dispose();
          deputiesApi.dispose();
        },
      )
    ];
  }
}
