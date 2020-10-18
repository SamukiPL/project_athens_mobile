import 'package:dio/dio.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nested/nested.dart';
import 'package:project_athens/athens_core/domain/list/base_params.dart';
import 'package:project_athens/athens_core/domain/list/list_use_case.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/deputies_utils/cache/deputies_cache.dart';
import 'package:project_athens/speeches_flow/data/network/speeches_api.dart';
import 'package:project_athens/speeches_flow/data/speeches_list_repository_impl.dart';
import 'package:project_athens/speeches_flow/mappers/speeches_network_mapper.dart';
import 'package:project_athens/speeches_flow/screens/list/list_impl/speech_item_view_model_factory.dart';
import 'package:project_athens/speeches_flow/screens/list/speeches_list_bloc.dart';
import 'package:provider/provider.dart';

class SpeechesListModule extends Module {
  SpeechesListModule(BuildContext context) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    final dio = Provider.of<Dio>(context);
    final speechesApi = SpeechesApi(dio);
    final deputiesCache = Provider.of<DeputiesCache>(context);
    final networkMapper = SpeechesNetworkMapper(deputiesCache);
    final speechesRepository = SpeechesListRepositoryImpl(speechesApi, networkMapper);
    final listUseCase = ListUseCase(speechesRepository);

    final itemFactory = SpeechItemViewModelFactory();

    return [
      Provider<SpeechesListBloc>(
        create: (context) => SpeechesListBloc(listUseCase, BaseParams(), itemFactory),
        dispose: (context, bloc) => bloc.dispose(),
      )
    ];
  }

}