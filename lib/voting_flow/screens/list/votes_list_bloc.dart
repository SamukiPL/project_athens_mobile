import 'dart:async';

import 'package:project_athens/athens_core/domain/data_mapper.dart';
import 'package:project_athens/athens_core/domain/list/base_params.dart';
import 'package:project_athens/athens_core/domain/list/list_use_case.dart';
import 'package:project_athens/athens_core/models/voting_model.dart';
import 'package:project_athens/athens_core/presentation/base_list_bloc.dart';
import 'package:project_athens/voting_flow/screens/list/list_impl/vote_item_view_model.dart';
import 'package:rxdart/rxdart.dart';

class VotesListBloc extends BaseListBloc<VotingModel, VoteItemViewModel, BaseParams> {

  VotesListBloc(ListUseCase<VotingModel, BaseParams> listUseCase, BaseParams params, DataMapper<VotingModel, VoteItemViewModel> itemFactory) : super(listUseCase, params, itemFactory);

  final StreamController<VotingModel> _goToDetails = PublishSubject();

  Stream<VotingModel> get goToDetails => _goToDetails.stream;

  @override
  Function(VotingModel p1) get itemClick => (VotingModel model) {
    _goToDetails.add(model);
  };

  @override
  void dispose() {
    _goToDetails.close();
    super.dispose();
  }
}