import 'package:dio/dio.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nested/nested.dart';
import 'package:project_athens/athens_core/data/base_list/items_repository_impl.dart';
import 'package:project_athens/athens_core/filters_and_sort/add_ons/easy_filters/easy_filters_list_bloc.dart';
import 'package:project_athens/athens_core/filters_and_sort/data/filters_repository.dart';
import 'package:project_athens/athens_core/filters_and_sort/domain/filterable_facade.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/athens_core/presentation/base_list/base_list_bloc.dart';
import 'package:project_athens/athens_core/presentation/search_app_bar/search_app_bar_facade.dart';
import 'package:project_athens/deputies_utils/cache/deputies_cache.dart';
import 'package:project_athens/deputies_utils/cache/subscribed_deputies_cache.dart';
import 'package:project_athens/speeches_flow/data/network/speeches_api.dart';
import 'package:project_athens/speeches_flow/data/speech_cache.dart';
import 'package:project_athens/speeches_flow/data/speeches_easy_filters_repository.dart';
import 'package:project_athens/speeches_flow/data/speeches_list_network_data_source.dart';
import 'package:project_athens/speeches_flow/domain/speeches_list_facade.dart';
import 'package:project_athens/speeches_flow/mappers/speeches_network_mapper.dart';
import 'package:project_athens/speeches_flow/screens/list/list_impl/speech_item_view_model_factory.dart';
import 'package:provider/provider.dart';

class SpeechesListModule extends Module {
  SpeechesListModule(BuildContext context) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    final dio = Provider.of<Dio>(context);
    final localizations = Provider.of<AppLocalizations>(context);
    final speechesApi = SpeechesApi(dio);
    final deputiesCache = Provider.of<DeputiesCache>(context);
    final subscribedDeputiesCache = Provider.of<SubscribedDeputiesCache>(context);
    final speechCache = Provider.of<SpeechCache>(context);
    final networkMapper = SpeechesNetworkMapper(deputiesCache);

    final networkDataSource = SpeechesListNetworkDataSource(speechesApi, networkMapper, speechCache, subscribedDeputiesCache);
    final speechesEasyFilters = SpeechesEasyFiltersRepository(deputiesCache, localizations);

    final speechesRepository = ItemsRepositoryImpl(networkDataSource);
    final filtersRepository = FiltersRepository(localizations);
    final listFacade = SpeechesListFacade(speechesRepository, filtersRepository, speechesEasyFilters);

    final itemFactory = SpeechItemViewModelFactory();

    return [
      Provider<BaseListBloc>(
        create: (context) => BaseListBloc(listFacade, itemFactory),
        dispose: (context, bloc) => bloc.dispose(),
      ),
      Provider<SearchAppBarFacade>(
        create: (_) => listFacade,
      ),
      Provider<FilterableFacade>(
        create: (_) => listFacade,
      ),
      Provider<EasyFiltersListBloc>.value(
          value: EasyFiltersListBloc(listFacade)
      )
    ];
  }

}