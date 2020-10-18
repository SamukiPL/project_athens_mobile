import 'package:dio/dio.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nested/nested.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/settings_flow/data/network/settings_api.dart';
import 'package:project_athens/settings_flow/data/settings/logout_repository_impl.dart';
import 'package:project_athens/settings_flow/domain/settings/logout_use_case.dart';
import 'package:project_athens/settings_flow/screens/settings/settings_bloc.dart';
import 'package:provider/provider.dart';

class SettingsModule extends Module {
  SettingsModule(BuildContext context) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    final client = Provider.of<Dio>(context);
    final settingsApi = SettingsApi(client);

    final logoutRepository = LogoutRepositoryImpl(settingsApi);
    final logoutUseCase = LogoutUseCase(logoutRepository);
    return [
      Provider<SettingsBloc>(
        create: (_) => SettingsBloc(logoutUseCase),
        dispose: (context, bloc) => bloc.dispose(),
      )
    ];
  }

}