import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:project_athens/athens_core/data/base_list/items_repository_impl.dart';
import 'package:project_athens/athens_core/filters_and_sort/add_ons/easy_filters/easy_filters_list_bloc.dart';
import 'package:project_athens/athens_core/filters_and_sort/data/filters_repository.dart';
import 'package:project_athens/athens_core/filters_and_sort/domain/filterable_facade.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/athens_core/presentation/base_list/base_list_bloc.dart';
import 'package:project_athens/athens_core/presentation/search_app_bar/search_app_bar_facade.dart';
import 'package:project_athens/deputies_flow/mappers/vote_slim_network_mapper.dart';
import 'package:project_athens/deputies_utils/cache/parliament_clubs_cache.dart';
import 'package:project_athens/deputies_utils/cache/subscribed_deputies_cache.dart';
import 'package:project_athens/voting_flow/data/network/voting_api.dart';
import 'package:project_athens/voting_flow/data/votes_easy_filters_repository.dart';
import 'package:project_athens/voting_flow/data/votes_list_network_data_source.dart';
import 'package:project_athens/voting_flow/domain/votes_list_facade.dart';
import 'package:project_athens/voting_flow/screens/list/list_impl/vote_item_view_model_factory.dart';
import 'package:provider/provider.dart';

class VotesListModule extends Module {

  VotesListModule(BuildContext context) : super(context);

  late final VotesListFacade _listFacade;
  late final BaseListBloc _bloc;
  late final EasyFiltersListBloc _filtersListBloc;

  @override
  List<SingleChildWidget> getProviders() {
    final dio = Provider.of<Dio>(context);
    final localizations = Provider.of<AppLocalizations>(context);
    final subscribedDeputiesCache = Provider.of<SubscribedDeputiesCache>(context);
    final clubsCache = Provider.of<ParliamentClubsCache>(context);
    final votingApi = VotingApi(dio);
    final networkMapper = VoteSlimNetworkMapper(subscribedDeputiesCache, clubsCache, localizations);

    final networkDataSource = VotesListNetworkDataSource(votingApi, networkMapper);
    final votesEasyFilters = VotesEasyFiltersRepository(localizations);

    final itemsRepository = ItemsRepositoryImpl(networkDataSource);
    final filtersRepository = FiltersRepository(localizations);
    _listFacade = VotesListFacade(itemsRepository, filtersRepository, votesEasyFilters);

    final itemFactory = VoteItemViewModelFactory();
    _bloc = BaseListBloc(_listFacade, itemFactory);
    _filtersListBloc = EasyFiltersListBloc(_listFacade);

    return [
      Provider<BaseListBloc>.value(
        value: _bloc,
      ),
      Provider<SearchAppBarFacade>.value(
        value: _listFacade,
      ),
      Provider<FilterableFacade>.value(
        value: _listFacade,
      ),
      Provider<EasyFiltersListBloc>.value(
        value: _filtersListBloc
      )
    ];
  }

  @override
  void dispose() {
    _bloc.dispose();
    _filtersListBloc.dispose();
  }
}
