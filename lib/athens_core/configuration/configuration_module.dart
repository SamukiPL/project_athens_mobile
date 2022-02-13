import 'package:project_athens/athens_core/chopper/simple_dio_client.dart';
import 'package:project_athens/athens_core/configuration/data/get_remote_configuration_repository_impl.dart';
import 'package:project_athens/athens_core/configuration/domain/get_remote_configuration_use_case.dart';
import 'package:project_athens/athens_core/configuration/network/remote_configuration_api.dart';
import 'package:project_athens/athens_core/configuration/remote_configuration.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

import 'configuration.dart';

class ConfigurationModule extends Module {
  ConfigurationModule(BuildContext context) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    return [
      Provider<Configuration>(
        create: (context) => Configuration(),
        dispose: (context, configuration) => configuration.dispose(),
      ),
      Provider<RemoteConfiguration>(
        create: (context) => _createRemoteConfiguration(context),
        dispose: (context, remoteConfiguration) => remoteConfiguration.dispose(),
        lazy: false,
      )
    ];
  }

  RemoteConfiguration _createRemoteConfiguration(BuildContext context2) {
    final _dio = Provider.of<SimpleDioClient>(context2, listen: false);
    final remoteConfigurationApi = RemoteConfigurationApi(_dio.client);
    final repository = GetRemoteConfigurationRepositoryImpl(remoteConfigurationApi);
    final useCase = GetRemoteConfigurationUseCase(repository);

    final RemoteConfiguration remoteConfig = RemoteConfiguration(useCase, context);

    remoteConfig.init();

    return remoteConfig;
  }
}
