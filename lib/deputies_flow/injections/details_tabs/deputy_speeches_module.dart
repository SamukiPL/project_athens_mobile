import 'package:dio/dio.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nested/nested.dart';
import 'package:project_athens/athens_core/data/base_list/items_repository_impl.dart';
import 'package:project_athens/athens_core/domain/base_list_facade.dart';
import 'package:project_athens/athens_core/filters_and_sort/data/filters_repository.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/athens_core/presentation/base_list/base_list_bloc.dart';
import 'package:project_athens/deputies_flow/data/deputy_speeches_network_data_source.dart';
import 'package:project_athens/deputies_flow/data/network/deputies_details_api.dart';
import 'package:project_athens/deputies_flow/screens/details/tabs/deputy_details_list_blocs.dart';
import 'package:project_athens/deputies_utils/cache/deputies_cache.dart';
import 'package:project_athens/deputies_utils/cache/parliament_clubs_cache.dart';
import 'package:project_athens/speeches_flow/mappers/speeches_network_mapper.dart';
import 'package:project_athens/speeches_flow/screens/list/list_impl/speech_item_view_model_factory.dart';
import 'package:provider/provider.dart';

class DeputySpeechesModule extends Module {

  final String _deputyId;

  DeputySpeechesModule(BuildContext context, this._deputyId) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    final dio = Provider.of<Dio>(context);
    final localizations = Provider.of<AppLocalizations>(context);
    final deputiesDetailsApi = DeputiesDetailsApi(dio);
    final deputiesCache = Provider.of<DeputiesCache>(context);
    final clubsCache = Provider.of<ParliamentClubsCache>(context);
    final networkMapper = SpeechesNetworkMapper(deputiesCache, clubsCache);

    final dataSource = DeputySpeechesNetworkDataSource(deputiesDetailsApi, networkMapper, _deputyId);
    final itemsRepository = ItemsRepositoryImpl(dataSource);
    final filtersRepository = FiltersRepository(localizations);

    final listFacade = BaseListFacade(itemsRepository, filtersRepository);

    final itemFactory = SpeechItemViewModelFactory(null);

    final listBloc = BaseListBloc(listFacade, itemFactory);

    return [
      Provider<DeputySpeechesDetailsBlocContainer>(
        create: (context) => DeputySpeechesDetailsBlocContainer(listBloc),
        dispose: (context, container) => container.listBloc.dispose(),
      ),
    ];
  }

}