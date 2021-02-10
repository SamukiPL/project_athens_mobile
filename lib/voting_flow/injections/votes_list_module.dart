import 'package:dio/dio.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nested/nested.dart';
import 'package:project_athens/athens_core/domain/base_list_facade.dart';
import 'package:project_athens/athens_core/domain/list/base_params.dart';
import 'package:project_athens/athens_core/domain/list/list_facade.dart';
import 'package:project_athens/athens_core/filters_and_sort/data/filters_repository.dart';
import 'package:project_athens/athens_core/filters_and_sort/domain/filterable_facade.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/athens_core/models/voting_model.dart';
import 'package:project_athens/athens_core/presentation/search_app_bar/search_app_bar_facade.dart';
import 'package:project_athens/voting_flow/data/network/voting_api.dart';
import 'package:project_athens/voting_flow/data/votes_list_repository_impl.dart';
import 'package:project_athens/voting_flow/mappers/voting_network_mapper.dart';
import 'package:project_athens/voting_flow/screens/list/list_impl/vote_item_view_model_factory.dart';
import 'package:project_athens/voting_flow/screens/list/votes_list_bloc.dart';
import 'package:provider/provider.dart';

class VotesListModule extends Module {

  VotesListModule(BuildContext context) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    final dio = Provider.of<Dio>(context);
    final localizations = Provider.of<AppLocalizations>(context);
    final votingApi = VotingApi(dio);
    final networkMapper = VotingNetworkMapper(localizations);

    final itemsRepository = VotesListRepositoryImpl(votingApi, networkMapper);
    final filtersRepository = FiltersRepository();
    final listFacade = BaseListFacade<VotingModel>(itemsRepository, filtersRepository);

    final itemFactory = VoteItemViewModelFactory();

    return [
      Provider<VotesListBloc>(
        create: (_) => VotesListBloc(listFacade, itemFactory),
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