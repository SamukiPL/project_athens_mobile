
import 'package:project_athens/athens_core/domain/data_mapper.dart';
import 'package:project_athens/athens_core/domain/list/base_params.dart';
import 'package:project_athens/athens_core/domain/list/list_facade.dart';
import 'package:project_athens/athens_core/models/voting_model.dart';
import 'package:project_athens/athens_core/navigation/bottom_navigation_bloc.dart';
import 'package:project_athens/athens_core/presentation/base_blocs/base_list_bloc.dart';
import 'package:project_athens/voting_flow/navigation/voting_destinations.dart';
import 'package:project_athens/voting_flow/screens/list/list_impl/vote_item_view_model.dart';

class VotesListBloc extends BaseListBloc<VotingModel, VoteItemViewModel, BaseParams> {

  VotesListBloc(ListFacade<VotingModel, BaseParams> listUseCase, DataMapper<VotingModel, VoteItemViewModel> itemFactory) : super(listUseCase, itemFactory);

  @override
  Function(VotingModel p1) get itemClick => (VotingModel model) {
    goToDestination(VoteDetailsDestination(BottomNavItem.VOTING, model));
  };

}