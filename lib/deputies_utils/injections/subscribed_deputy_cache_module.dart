import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/auth/auth_repository_impl.dart';
import 'package:project_athens/athens_core/auth/network/auth_api.dart';
import 'package:project_athens/athens_core/chopper/auth_facade.dart';
import 'package:project_athens/athens_core/chopper/auth_interceptor.dart';
import 'package:project_athens/athens_core/chopper/error_interceptor.dart';
import 'package:project_athens/athens_core/chopper/network_module.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/athens_core/utils/firebase/firebase_deputy_subscriber.dart';
import 'package:project_athens/deputies_utils/cache/deputies_cache.dart';
import 'package:project_athens/deputies_utils/cache/subscribed_deputies_cache.dart';
import 'package:project_athens/deputies_utils/data/delete_deputy_repository_impl.dart';
import 'package:project_athens/deputies_utils/data/firebase_deputies_repository_impl.dart';
import 'package:project_athens/deputies_utils/data/network/deputies_api.dart';
import 'package:project_athens/deputies_utils/data/put_deputies_repository_impl.dart';
import 'package:project_athens/deputies_utils/domain/delete_deputy/delete_deputy_use_case.dart';
import 'package:project_athens/deputies_utils/domain/firebase_deputies/firebase_deputies_use_case.dart';
import 'package:project_athens/deputies_utils/domain/put_deputies/deputies_registration_use_case.dart';
import 'package:project_athens/main/firebase/firebase_messages.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class SubscribedDeputyCacheModule extends Module {
  final FirebaseMessages _firebaseMessages;

  SubscribedDeputyCacheModule(BuildContext context, this._firebaseMessages) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    final clientOptions = BaseOptions(
      baseUrl: "https://api.swiadoma-demokracja.pl",
    );
    final client = Dio(clientOptions);

    final refreshClient = SimpleDioClient(Dio()).client;
    final authApi = AuthApi(refreshClient);
    final authRepository = AuthRepositoryImpl(authApi);
    final authFacade = AuthFacade(authRepository);

    client.interceptors.addAll([AuthInterceptor(authFacade),  LogInterceptor(requestBody: true, responseBody: true), ErrorInterceptor()]);

    final deputiesApi = DeputiesApi(client);

    final DeputiesCache _deputiesCache = Provider.of<DeputiesCache>(context);

    final firebaseDeputySubscriber = FirebaseDeputySubscriber(_firebaseMessages);
    final firebaseDeputiesRepository = FirebaseDeputiesRepositoryImpl(deputiesApi, firebaseDeputySubscriber);
    final firebaseDeputiesUseCase = FirebaseDeputiesUseCase(firebaseDeputiesRepository);

    final putDeputyRepository = PutDeputiesRepositoryImpl(deputiesApi, firebaseDeputySubscriber);
    final putDeputyUseCase = PutDeputiesUseCase(putDeputyRepository);

    final deleteDeputyRepository = DeleteDeputyRepositoryImpl(deputiesApi, firebaseDeputySubscriber);
    final deleteDeputyUseCase = DeleteDeputyUseCase(deleteDeputyRepository);

    return List<SingleChildWidget>.of([
      Provider<SubscribedDeputiesCache>(
        create: (_) => SubscribedDeputiesCache(_deputiesCache, firebaseDeputiesUseCase, deleteDeputyUseCase, putDeputyUseCase),
        dispose: (context, cache) => cache.dispose(),
      )
    ]);
  }
}