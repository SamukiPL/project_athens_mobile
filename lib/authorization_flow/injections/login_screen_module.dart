import 'package:chopper/chopper.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/athens_core/utils/firebase/firebase_deputy_subscriber.dart';
import 'package:project_athens/authorization_flow/data/login_repository_impl.dart';
import 'package:project_athens/authorization_flow/data/network/login_api.dart';
import 'package:project_athens/authorization_flow/domain/login/login_repository.dart';
import 'package:project_athens/authorization_flow/domain/login/login_use_case.dart';
import 'package:project_athens/authorization_flow/screens/login/login_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:nested/nested.dart';
import 'package:project_athens/deputies_utils/data/firebase_deputies_repository_impl.dart';
import 'package:project_athens/deputies_utils/data/network/deputies_api.dart';
import 'package:project_athens/deputies_utils/domain/firebase_deputies/firebase_deputies_use_case.dart';
import 'package:project_athens/main/firebase/firebase_messages.dart';
import 'package:provider/provider.dart';

class LoginScreenModule extends Module {

  LoginScreenModule(BuildContext context) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    LoginApi loginApi = Provider.of<LoginApi>(context);
    LoginRepository loginRepository = LoginRepositoryImpl(loginApi);
    LoginUseCase loginUseCase = LoginUseCase(loginRepository);

    final firebaseDeputiesUseCase = getFirebaseDeputiesUseCase(context);

    return List.of([
      Provider<LoginBloc>(
        create: (_) => LoginBloc(loginUseCase, firebaseDeputiesUseCase),
        dispose: (context, bloc) => bloc.dispose(),
      )
    ]);
  }

  FirebaseDeputiesUseCase getFirebaseDeputiesUseCase(BuildContext context) {
    final chopperClient = Provider.of<ChopperClient>(context);
    final deputiesApi = DeputiesApi.create(chopperClient);

    final firebaseMessaging = Provider.of<FirebaseMessages>(context);
    final deputySubscriber = FirebaseDeputySubscriber(firebaseMessaging);

    final firebaseDeputiesRepository = FirebaseDeputiesRepositoryImpl(deputiesApi, deputySubscriber);
    return FirebaseDeputiesUseCase(firebaseDeputiesRepository);
  }

}
