import 'package:dio/dio.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nested/nested.dart';
import 'package:project_athens/athens_core/auto_updater/auto_updater.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/more_flow/data/more/logout_repository_impl.dart';
import 'package:project_athens/more_flow/data/network/more_api.dart';
import 'package:project_athens/more_flow/domain/more/logout_use_case.dart';
import 'package:project_athens/more_flow/screens/more/more_bloc.dart';
import 'package:provider/provider.dart';

class MoreModule extends Module {
  MoreModule(BuildContext context) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    final client = Provider.of<Dio>(context);
    final moreApi = MoreApi(client);

    final logoutRepository = LogoutRepositoryImpl(moreApi);
    final logoutUseCase = LogoutUseCase(logoutRepository);

    final AutoUpdater _autoUpdater = Provider.of<AutoUpdater>(context);

    return [
      Provider<MoreBloc>(
        create: (_) => MoreBloc(logoutUseCase, _autoUpdater),
        dispose: (context, bloc) => bloc.dispose(),
      ),
    ];
  }
}
