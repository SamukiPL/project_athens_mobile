import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:nested/nested.dart';
import 'package:project_athens/athens_core/ads/native_ad/native_ad_provider.dart';
import 'package:project_athens/athens_core/ads/native_ad/native_ads.dart';
import 'package:project_athens/athens_core/data/base_list/items_repository_impl.dart';
import 'package:project_athens/athens_core/db/athens_db.dart';
import 'package:project_athens/athens_core/filters_and_sort/add_ons/easy_filters/easy_filters_list_bloc.dart';
import 'package:project_athens/athens_core/filters_and_sort/data/filters_repository.dart';
import 'package:project_athens/athens_core/filters_and_sort/domain/filterable_facade.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/athens_core/presentation/base_list/base_list_bloc.dart';
import 'package:project_athens/athens_core/presentation/search_app_bar/search_app_bar_facade.dart';
import 'package:project_athens/deputies_flow/data/network/deputies_details_api.dart';
import 'package:project_athens/deputies_flow/data/votes/deputy_votes_easy_filters_repository.dart';
import 'package:project_athens/deputies_flow/data/votes/deputy_votes_local_data_source.dart';
import 'package:project_athens/deputies_flow/data/votes/deputy_votes_network_data_source.dart';
import 'package:project_athens/deputies_flow/domain/votes/deputy_votes_list_facade.dart';
import 'package:project_athens/deputies_flow/mappers/vote_slim_network_mapper.dart';
import 'package:project_athens/deputies_flow/screens/votes_list/list_impl/deputy_votes_list_item_view_model_factory.dart';
import 'package:project_athens/deputies_utils/cache/parliament_clubs_cache.dart';
import 'package:project_athens/deputies_utils/cache/subscribed_deputies_cache.dart';
import 'package:project_athens/voting_flow/data/db/mappers/voting_entity_mapper.dart';
import 'package:project_athens/voting_flow/data/db/mappers/voting_model_dao_mapper.dart';
import 'package:provider/provider.dart';

class DeputyVotesListModule extends Module {
  final String _deputyId;

  DeputyVotesListModule(BuildContext context, this._deputyId) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    final dio = Provider.of<Dio>(context);
    final localizations = Provider.of<AppLocalizations>(context);
    final deputiesDetailsApi = DeputiesDetailsApi(dio);
    final deputiesCache = Provider.of<SubscribedDeputiesCache>(context);
    final clubsCache = Provider.of<ParliamentClubsCache>(context);
    final networkMapper = VoteSlimNetworkMapper(deputiesCache, clubsCache, localizations);

    final database = Provider.of<AthensDatabase>(context);
    final entityMapper = VotingEntityMapper(downloadedForDeputy: _deputyId);
    final speechModelDaoMapper = VotingModelDaoMapper(database, deputiesCache, clubsCache, localizations);
    final localDataSource = DeputyVotesListLocalDataSource(database, entityMapper, speechModelDaoMapper, _deputyId);

    final dataSource = DeputyVotesNetworkDataSource(deputiesDetailsApi, networkMapper, _deputyId, localDataSource);
    final itemsRepository = ItemsRepositoryImpl(dataSource);
    final filtersRepository = FiltersRepository(localizations);
    final easyFilters = DeputyVotesEasyFiltersRepository(localizations);

    final listFacade = DeputyVotesListFacade(itemsRepository, filtersRepository, easyFilters);
    final itemFactory = DeputyVotesListItemViewModelFactory();
    final _bloc = BaseListBloc(listFacade, itemFactory);
    final _filtersListBloc = EasyFiltersListBloc(listFacade);

    return [
      Provider<BaseListBloc>.value(
        value: _bloc,
      ),
      Provider<SearchAppBarFacade>.value(
        value: listFacade,
      ),
      Provider<FilterableFacade>.value(
        value: listFacade,
      ),
      Provider<EasyFiltersListBloc>.value(value: _filtersListBloc),
      Provider<NativeAdProvider>(
        create: (_) => NativeAdProvider(NativeAds.speechAd),
        dispose: (_, adProvider) => adProvider.dispose(),
      )
    ];
  }
}
