import 'dart:async';

import 'package:project_athens/athens_core/models/voting_model.dart';
import 'package:project_athens/athens_core/presentation/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

class VoteDetailsBloc extends BaseBloc {

  final VotingModel _votingModel;

  VoteDetailsBloc(this._votingModel);

  final StreamController<List<String>> _goToDeputiesList = PublishSubject();

  Stream<List<String>> get goToDeputiesList => _goToDeputiesList.stream;

  Future<void> prepareList(VoteType voteType) async {
    List<String> deputiesIds = _votingModel.votes
        .where((element) => element.type == voteType)
        .map((e) => e.cadencyDeputy)
        .toList();
    _goToDeputiesList.add(deputiesIds);
  }

  @override
  void dispose() {
    _goToDeputiesList.close();
    super.dispose();
  }

}