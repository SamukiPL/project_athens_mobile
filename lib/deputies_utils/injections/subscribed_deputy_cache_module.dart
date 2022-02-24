import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/athens_core/ext/provider_extension.dart';
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
import 'package:project_athens/guest_flow/domain/logged_state.dart';
import 'package:project_athens/main/firebase/firebase_messages.dart';
import 'package:project_athens/athens_core/chopper/authenticated_dio_client.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class SubscribedDeputyCacheModule extends Module {
  final FirebaseMessages _firebaseMessages;

  SubscribedDeputyCacheModule(BuildContext context, this._firebaseMessages) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    final AuthenticatedDioClient dioClient = Provider.of<AuthenticatedDioClient>(context);
    final deputiesApi = DeputiesApi(dioClient.client);

    final loggedState = providerWithDefault<LoggedState>(context, LoggedState.userLogged());
    final DeputiesCache deputiesCache = Provider.of<DeputiesCache>(context);

    final firebaseDeputySubscriber = FirebaseDeputySubscriber(_firebaseMessages);
    final firebaseDeputiesRepository = FirebaseDeputiesRepositoryImpl(deputiesApi, deputiesCache, firebaseDeputySubscriber, loggedState: loggedState);
    final firebaseDeputiesUseCase = FirebaseDeputiesUseCase(firebaseDeputiesRepository);

    final putDeputyRepository = PutDeputiesRepositoryImpl(deputiesApi, firebaseDeputySubscriber);
    final putDeputyUseCase = PutDeputiesUseCase(putDeputyRepository);

    final deleteDeputyRepository = DeleteDeputyRepositoryImpl(deputiesApi, firebaseDeputySubscriber);
    final deleteDeputyUseCase = DeleteDeputyUseCase(deleteDeputyRepository);

    return List<SingleChildWidget>.of([
      Provider<SubscribedDeputiesCache>(
        create: (_) => SubscribedDeputiesCache(firebaseDeputiesUseCase, deleteDeputyUseCase, putDeputyUseCase),
        dispose: (context, cache) => cache.dispose(),
      )
    ]);
  }
}