import 'package:dio/dio.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nested/nested.dart';
import 'package:project_athens/athens_core/data/base_list/items_repository_impl.dart';
import 'package:project_athens/athens_core/domain/base_list_facade.dart';
import 'package:project_athens/athens_core/filters_and_sort/data/filters_repository.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/athens_core/presentation/base_list/base_list_bloc.dart';
import 'package:project_athens/deputies_flow/data/deputy_votes_network_data_source.dart';
import 'package:project_athens/deputies_flow/data/network/deputies_details_api.dart';
import 'package:project_athens/voting_flow/mappers/voting_network_mapper.dart';
import 'package:project_athens/voting_flow/screens/list/list_impl/vote_item_view_model_factory.dart';
import 'package:provider/provider.dart';

class DeputyVotingsModule extends Module {

  final String _deputyId;

  DeputyVotingsModule(BuildContext context, this._deputyId) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    final dio = Provider.of<Dio>(context);
    final votesDetailsApi = DeputiesDetailsApi(dio);
    final localizations = Provider.of<AppLocalizations>(context);
    final networkMapper = VotingNetworkMapper(localizations);

    final dataSource = DeputyVotesNetworkDataSource(votesDetailsApi, networkMapper, 9, _deputyId);
    final itemsRepository = ItemsRepositoryImpl(dataSource);
    final filtersRepository = FiltersRepository();

    final listFacade = BaseListFacade(itemsRepository, filtersRepository);

    final itemFactory = VoteItemViewModelFactory();

    return [
      Provider<BaseListBloc>(
        create: (context) => BaseListBloc(listFacade, itemFactory),
        dispose: (context, bloc) => bloc.dispose(),
      ),
    ];
  }

}