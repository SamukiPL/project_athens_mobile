import 'package:athens_core/injections/module.dart';
import 'package:authorization_flow/data/deputies_registration_repository_impl.dart';
import 'package:authorization_flow/data/network/deputies_api.dart';
import 'package:authorization_flow/domain/deputies_registration/deputies_registration_use_case.dart';
import 'package:authorization_flow/screens/deputies_registration/deputies_registration_bloc.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

class DeputiesRegistrationModule extends Module {
  DeputiesRegistrationModule(BuildContext context) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    final chopperClient = Provider.of<ChopperClient>(context);
    final deputiesApi = DeputiesApi.create(chopperClient);
    final deputiesRepository = DeputiesRegistrationRepositoryImpl(deputiesApi);
    final deputiesRegistrationUseCase =
        DeputiesRegistrationUseCase(deputiesRepository);
    return [
      Provider<DeputiesRegistrationBloc>(
        create: (_) => DeputiesRegistrationBloc(deputiesRegistrationUseCase),
        dispose: (context, bloc) {
          bloc.dispose();
          deputiesApi.dispose();
        },
      )
    ];
  }
}
