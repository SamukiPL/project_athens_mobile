import 'package:dio/dio.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nested/nested.dart';
import 'package:project_athens/athens_core/domain/list/base_params.dart';
import 'package:project_athens/athens_core/domain/list/list_use_case.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/athens_core/models/timeline_model.dart';
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
    final votingApi = VotingApi(dio);
    final networkMapper = VotingNetworkMapper();

    final itemsRepository = VotesListRepositoryImpl(votingApi, networkMapper);

    final listUseCase = ListUseCase<VotingModel, BaseParams>(itemsRepository);

    final params = BaseParams();

    final itemFactory = VoteItemViewModelFactory();

    return [
      Provider<VotesListBloc>(
        create: (_) => VotesListBloc(listUseCase, params, itemFactory),
        dispose: (_, bloc) => bloc.dispose(),
      )
    ];
  }

}