import 'dart:async';

import 'package:project_athens/athens_core/data/vote/vote_slim_model.dart';
import 'package:project_athens/athens_core/models/voting_model.dart';
import 'package:project_athens/athens_core/presentation/base_blocs/base_bloc.dart';
import 'package:project_athens/athens_core/presentation/base_item_view_model.dart';
import 'package:project_athens/timeline_flow/helpers/timeline_voting_agenda_helper.dart';
import 'package:project_athens/timeline_flow/screens/timeline/list/timeline_row_view_model_factory.dart';
import 'package:project_athens/athens_core/models/timeline_model.dart';
import 'package:project_athens/athens_core/presentation/data_loading/data_loading_state.dart';
import 'package:project_athens/voting_flow/navigation/voting_destinations.dart';
import 'package:rxdart/rxdart.dart';

class GroupDetailsBloc extends BaseBloc {
  final GroupedVotingModel _groupedModel;

  GroupDetailsBloc(this._groupedModel);

  final StreamController<VotingModel> _destination = BehaviorSubject();

  Stream<VotingModel> get destination => _destination.stream;

  String? get agenda =>  getAgendaWithoutExtras(_groupedModel.agenda);
  String get header {
    if (_groupedModel.orderPoint != null) {
      return 'Pkt. ' + _groupedModel.orderPoint.toString() + ' - ' + _groupedModel.votingDesc;
    } else {
      return _groupedModel.votingDesc;
    }
  }

  Future<List<BaseItemViewModel>> getListItems() async {
    final list = _groupedModel.groupedVotes.toTimelineRowViewModel();
    setLoadingState(DataLoadingState.contentLoaded());
    return list;
  }

  void itemClick(TimelineModel model) {
    goToDestination(VoteDetailsDestination(
        VoteSlimModel.fromVotingModel(model as VotingModel)));
  }

  @override
  void dispose() {
    _destination.close();
    super.dispose();
  }
}
