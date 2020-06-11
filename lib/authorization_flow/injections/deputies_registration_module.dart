import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/authorization_flow/screens/deputies_registration/deputies_registration_bloc.dart';
import 'package:project_athens/deputies_utils/data/get_deputies_repository_impl.dart';
import 'package:project_athens/deputies_utils/data/network/deputies_api.dart';
import 'package:project_athens/deputies_utils/data/put_deputies_repository_impl.dart';
import 'package:project_athens/deputies_utils/domain/get_deputies/get_deputies_use_case.dart';
import 'package:project_athens/deputies_utils/domain/put_deputies/deputies_registration_use_case.dart';
import 'package:provider/provider.dart';

class DeputiesRegistrationModule extends Module {
  DeputiesRegistrationModule(BuildContext context) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    final chopperClient = Provider.of<ChopperClient>(context);
    final deputiesApi = DeputiesApi.create(chopperClient);
    final getDeputiesRepository = GetDeputiesRepositoryImpl(deputiesApi);
    final getDeputiesUseCase = GetDeputiesUseCase(getDeputiesRepository);
    final putDeputiesRepository = PutDeputiesRepositoryImpl(deputiesApi);
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
