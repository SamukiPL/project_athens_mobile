import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:project_athens/athens_core/data/base_list/items_repository_impl.dart';
import 'package:project_athens/athens_core/domain/base_list_facade.dart';
import 'package:project_athens/athens_core/filters_and_sort/data/filters_repository.dart';
import 'package:project_athens/athens_core/filters_and_sort/domain/filterable_facade.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/athens_core/presentation/base_list/base_list_bloc.dart';
import 'package:project_athens/athens_core/presentation/search_app_bar/search_app_bar_facade.dart';
import 'package:project_athens/voting_flow/data/network/voting_api.dart';
import 'package:project_athens/voting_flow/data/votes_list_network_data_source.dart';
import 'package:project_athens/voting_flow/mappers/voting_network_mapper.dart';
import 'package:project_athens/voting_flow/screens/list/list_impl/vote_item_view_model_factory.dart';
import 'package:provider/provider.dart';

class VotesListModule extends Module {

  VotesListModule(BuildContext context) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    final dio = Provider.of<Dio>(context);
    final localizations = Provider.of<AppLocalizations>(context);
    final votingApi = VotingApi(dio);
    final networkMapper = VotingNetworkMapper(localizations);

    final networkDataSource = VotesListNetworkDataSource(votingApi, networkMapper);

    final itemsRepository = ItemsRepositoryImpl(networkDataSource);
    final filtersRepository = FiltersRepository();
    final listFacade = BaseListFacade(itemsRepository, filtersRepository);

    final itemFactory = VoteItemViewModelFactory();

    return [
      Provider<BaseListBloc>(
        create: (_) => BaseListBloc(listFacade, itemFactory),
        dispose: (_, bloc) => bloc.dispose(),
      ),
      Provider<SearchAppBarFacade>(
        create: (_) => listFacade,
      ),
      Provider<FilterableFacade>(
        create: (_) => listFacade,
      ),
    ];
  }

}