import 'package:dio/dio.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nested/nested.dart';
import 'package:project_athens/athens_core/data/base_list/items_repository_impl.dart';
import 'package:project_athens/athens_core/domain/base_list_facade.dart';
import 'package:project_athens/athens_core/filters_and_sort/data/filters_repository.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/athens_core/presentation/base_list/base_list_bloc.dart';
import 'package:project_athens/deputies_flow/data/deputy_vote_accuracy_network_data_source.dart';
import 'package:project_athens/deputies_flow/data/network/deputies_details_api.dart';
import 'package:project_athens/deputies_flow/domain/deputy_vote_accuracy_list_facade.dart';
import 'package:project_athens/deputies_flow/domain/vote_accuracy_alignment_enum.dart';
import 'package:project_athens/deputies_flow/mappers/vote_slim_majority_network_mapper.dart';
import 'package:project_athens/deputies_flow/screens/vote_accuracy/deputy_vote_accuracy_list_impl/deputy_vote_accuracy_item_view_model_factory.dart';
import 'package:project_athens/deputies_utils/cache/deputies_cache.dart';
import 'package:project_athens/deputies_utils/cache/subscribed_deputies_cache.dart';
import 'package:project_athens/deputies_utils/domain/deputy_full.dart';
import 'package:project_athens/deputies_utils/domain/subscribed_deputy_model.dart';
import 'package:project_athens/voting_flow/data/network/voting_api.dart';
import 'package:provider/provider.dart';

class DeputyVoteAccuracyModule extends Module {

  final SubscribedDeputyModel _deputyModel;
  final ClubVoteAccuracy _clubVoteAccuracy;
  final VoteAccuracyAlignment _alignment;

  DeputyVoteAccuracyModule(BuildContext context, this._deputyModel, this._alignment, this._clubVoteAccuracy) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    final dio = Provider.of<Dio>(context);
    final localizations = Provider.of<AppLocalizations>(context);
    final votingApi = VotingApi(dio);
    final deputiesApi = DeputiesDetailsApi(dio);

    final subscribedDeputies = Provider.of<SubscribedDeputiesCache>(context);
    final deputiesCache = Provider.of<DeputiesCache>(context);

    final networkMapper = VoteSlimMajorityNetworkMapper(subscribedDeputies, deputiesCache, _deputyModel.cadencyDeputyId, _clubVoteAccuracy.parliamentClub, localizations);

    final networkDataSource = VoteSlimMajorityModelNetworkDataSource(deputiesApi, networkMapper);

    final itemsRepository = ItemsRepositoryImpl(networkDataSource);
    final filtersRepository = FiltersRepository(localizations);
    final listFacade = DeputyVoteAccuracyListFacade(_deputyModel.cadencyDeputyId, _clubVoteAccuracy.parliamentClub.id, _alignment, itemsRepository);

    final itemFactory = DeputyVoteAccuracyItemViewModelFactory();

    return [
      Provider<BaseListBloc>(
        create: (context) => BaseListBloc(listFacade, itemFactory),
        dispose: (context, bloc) => bloc.dispose(),
      )
    ];
  }

}