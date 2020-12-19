import 'dart:async';
import 'dart:convert';

import 'package:project_athens/athens_core/data/base_responses/voting_response.dart';
import 'package:project_athens/athens_core/domain/list/base_params.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/models/voting_model.dart';
import 'package:project_athens/voting_flow/data/network/voting_api.dart';
import 'package:project_athens/voting_flow/domain/list/votes_list_repository.dart';
import 'package:project_athens/voting_flow/mappers/voting_network_mapper.dart';
import 'package:rxdart/rxdart.dart';

class VotesListRepositoryImpl extends VotesListRepository {

  final VotingApi _votingApi;

  final VotingNetworkMapper _networkMapper;

  final StreamController<Result<List<VotingModel>>> _speechesSubject = BehaviorSubject<Result<List<VotingModel>>>();

  VotesListRepositoryImpl(this._votingApi, this._networkMapper);

  @override
  Future<void> fetchItems(int limit, int offset) async {}

  @override
  Stream<Result<List<VotingModel>>> getItems(BaseParams params) {
    mockData();

    return _speechesSubject.stream;
  }

  @override
  Future<void> refreshItems() async {}

  @override
  void dispose() {
    _speechesSubject.close();
  }

  Future<void> mockData() async {
    final response = VotingResponse.fromJson(json.decode(mockVoting));
    final model = _networkMapper.transform(response);
    final absoluteMajoritymodel = _networkMapper.transform(VotingResponse.fromJson(json.decode(absoluteMajorityMockVoting)));
    final qualifyingMajoritymodel = _networkMapper.transform(VotingResponse.fromJson(json.decode(qualifyingMajorityMockVoting)));
    List<VotingModel> test = [model, absoluteMajoritymodel, qualifyingMajoritymodel];
    final result = Success(test);
    _speechesSubject.add(result);
  }

  final mockVoting = "{\"votingNumbers\":{\"inFavor\":262,\"against\":42,\"hold\":114,\"absent\":42},\"votedAt\":\"2020-12-09T10:10:53.000Z\",\"actualVotedAt\":\"2020-12-09T10:10:53.000Z\",\"createAt\":\"2020-12-17T21:14:47.724Z\",\"_id\":\"5fdc703290c42013dc18b436\",\"cadency\":9,\"orderPoint\":null,\"sessionIId\":22,\"votingIId\":1,\"votingUniqueId\":\"9_22_1\",\"topic\":\"22. posiedzenie Sejmu Rzeczypospolitej Polskiej w dniach 9 i 10 grudnia 2020 r. - stwierdzenie kworum\",\"agendaPoint\":\"5fdc703290c42013dc18b435\",\"votes\":[{\"_id\":\"5fdc703290c42013dc18b528\",\"type\":3,\"cadencyDeputy\":\"5ea83ea5f75d4e47cc83a162\"},{\"_id\":\"5fdc703290c42013dc18b5a9\",\"type\":0,\"cadencyDeputy\":\"5ea83ea5f75d4e47cc839fee\"},{\"_id\":\"5fdc703290c42013dc18b5d4\",\"type\":1,\"cadencyDeputy\":\"5ea83ea5f75d4e47cc839f0d\"},{\"_id\":\"5fdc703290c42013dc18b5d5\",\"type\":1,\"cadencyDeputy\":\"5ea83ea5f75d4e47cc83a0dc\"},{\"_id\":\"5fdc703290c42013dc18b5de\",\"type\":2,\"cadencyDeputy\":\"5ea83ea5f75d4e47cc83a155\"},{\"_id\":\"5fdc703290c42013dc18b5f1\",\"type\":3,\"cadencyDeputy\":\"5ea83ea5f75d4e47cc839eb4\"}],\"votingType\":999,\"parliamentClubVotingNumbers\":[{\"_id\":\"5fdc703290c42013dc18b603\",\"absent\":16,\"inFavor\":182,\"hold\":31,\"against\":5,\"totalDeputies\":234,\"actualVoted\":218,\"parliamentClub\":\"5fabd23f9889252626a19239\"},{\"_id\":\"5fdc703290c42013dc18b604\",\"absent\":13,\"inFavor\":44,\"hold\":50,\"against\":27,\"totalDeputies\":134,\"actualVoted\":121,\"parliamentClub\":\"5fabd23f9889252626a19240\"},{\"_id\":\"5fdc703290c42013dc18b605\",\"absent\":4,\"inFavor\":27,\"hold\":11,\"against\":6,\"totalDeputies\":48,\"actualVoted\":44,\"parliamentClub\":\"5fabd23f9889252626a1923a\"},{\"_id\":\"5fdc703290c42013dc18b606\",\"absent\":3,\"inFavor\":6,\"hold\":14,\"against\":1,\"totalDeputies\":24,\"actualVoted\":21,\"parliamentClub\":\"5fc2e5db9889252626ba19cb\"},{\"_id\":\"5fdc703290c42013dc18b607\",\"absent\":5,\"inFavor\":1,\"hold\":2,\"against\":3,\"totalDeputies\":11,\"actualVoted\":6,\"parliamentClub\":\"5fabd23f9889252626a1923b\"},{\"_id\":\"5fdc703290c42013dc18b608\",\"absent\":1,\"inFavor\":2,\"hold\":6,\"against\":0,\"totalDeputies\":9,\"actualVoted\":8,\"parliamentClub\":\"5fabd23f9889252626a1923f\"}],\"absoluteMajority\":null,\"qualifyingMajority\":null,\"__v\":0,\"id\":\"5fdc703290c42013dc18b436\"}";
  final absoluteMajorityMockVoting = "{\"votingNumbers\":{\"inFavor\":226,\"against\":216,\"hold\":1,\"absent\":17},\"votedAt\":\"2020-12-09T18:58:41.000Z\",\"actualVotedAt\":\"2020-12-09T18:58:41.000Z\",\"createAt\":\"2020-12-17T21:14:47.724Z\",\"_id\":\"5fdc714e90c42013dc192b09\",\"cadency\":9,\"orderPoint\":10,\"sessionIId\":22,\"votingIId\":66,\"votingUniqueId\":\"9_22_66\",\"topic\":\"Pkt 10. porz. dzien. Sprawozdanie Komisji o uchwale Senatu w sprawie ustawy o zmianie ustawy o szczeg\u00f3lnych rozwi\u0105zaniach zwi\u0105zanych z zapobieganiem, przeciwdzia\u0142aniem i zwalczaniem COVID-19, innych chor\u00f3b zaka\u017anych oraz wywo\u0142anych nimi sytuacji kryzysowych oraz niekt\u00f3rych innych ustaw G\u0142osowanie nad odrzuceniem poprawek 65., 148., 215., 289., 362. i 428.\",\"agendaPoint\":\"5fdc714e90c42013dc192b08\",\"votes\":[{\"_id\":\"5fdc714e90c42013dc192bfb\",\"type\":1,\"cadencyDeputy\":\"5ea83ea5f75d4e47cc83a162\"},{\"_id\":\"5fdc714e90c42013dc192c7c\",\"type\":3,\"cadencyDeputy\":\"5ea83ea5f75d4e47cc839fee\"},{\"_id\":\"5fdc714e90c42013dc192ca7\",\"type\":1,\"cadencyDeputy\":\"5ea83ea5f75d4e47cc839f0d\"},{\"_id\":\"5fdc714e90c42013dc192ca8\",\"type\":1,\"cadencyDeputy\":\"5ea83ea5f75d4e47cc83a0dc\"},{\"_id\":\"5fdc714e90c42013dc192cb1\",\"type\":1,\"cadencyDeputy\":\"5ea83ea5f75d4e47cc83a155\"},{\"_id\":\"5fdc714e90c42013dc192cc4\",\"type\":3,\"cadencyDeputy\":\"5ea83ea5f75d4e47cc839eb4\"}],\"votingType\":4,\"parliamentClubVotingNumbers\":[{\"_id\":\"5fdc714e90c42013dc192cd6\",\"absent\":6,\"inFavor\":226,\"hold\":0,\"against\":2,\"totalDeputies\":234,\"actualVoted\":228,\"parliamentClub\":\"5fabd23f9889252626a19239\"},{\"_id\":\"5fdc714e90c42013dc192cd7\",\"absent\":3,\"inFavor\":0,\"hold\":0,\"against\":131,\"totalDeputies\":134,\"actualVoted\":131,\"parliamentClub\":\"5fabd23f9889252626a19240\"},{\"_id\":\"5fdc714e90c42013dc192cd8\",\"absent\":5,\"inFavor\":0,\"hold\":0,\"against\":43,\"totalDeputies\":48,\"actualVoted\":43,\"parliamentClub\":\"5fabd23f9889252626a1923a\"},{\"_id\":\"5fdc714e90c42013dc192cd9\",\"absent\":1,\"inFavor\":0,\"hold\":0,\"against\":23,\"totalDeputies\":24,\"actualVoted\":23,\"parliamentClub\":\"5fc2e5db9889252626ba19cb\"},{\"_id\":\"5fdc714e90c42013dc192cda\",\"absent\":1,\"inFavor\":0,\"hold\":0,\"against\":10,\"totalDeputies\":11,\"actualVoted\":10,\"parliamentClub\":\"5fabd23f9889252626a1923b\"},{\"_id\":\"5fdc714e90c42013dc192cdb\",\"absent\":1,\"inFavor\":0,\"hold\":1,\"against\":7,\"totalDeputies\":9,\"actualVoted\":8,\"parliamentClub\":\"5fabd23f9889252626a1923f\"}],\"absoluteMajority\":222,\"qualifyingMajority\":null,\"__v\":0,\"id\":\"5fdc714e90c42013dc192b09\"}";
  final qualifyingMajorityMockVoting = "{\"votingNumbers\":{\"inFavor\":216,\"against\":233,\"hold\":1,\"absent\":10},\"votedAt\":\"2020-12-09T22:50:01.000Z\",\"actualVotedAt\":\"2020-12-09T22:50:01.000Z\",\"createAt\":\"2020-12-17T21:14:47.724Z\",\"_id\":\"5fdc726990c42013dc199e34\",\"cadency\":9,\"orderPoint\":11,\"sessionIId\":22,\"votingIId\":129,\"votingUniqueId\":\"9_22_129\",\"topic\":\"Pkt 11. porz. dzien. Wniosek o wyra\u017cenie wotum nieufno\u015bci wobec Wiceprezesa Rady Ministr\u00f3w Jaros\u0142awa Kaczy\u0144skiego G\u0142osowanie nad przyj\u0119ciem wniosku o wyra\u017cenie wotum nieufno\u015bci wobec wiceprezesa Rady Ministr\u00f3w\",\"agendaPoint\":\"5fdc726990c42013dc199e33\",\"votes\":[{\"_id\":\"5fdc726990c42013dc199f26\",\"type\":0,\"cadencyDeputy\":\"5ea83ea5f75d4e47cc83a162\"},{\"_id\":\"5fdc726990c42013dc199fa7\",\"type\":0,\"cadencyDeputy\":\"5ea83ea5f75d4e47cc839fee\"},{\"_id\":\"5fdc726990c42013dc199fd2\",\"type\":0,\"cadencyDeputy\":\"5ea83ea5f75d4e47cc839f0d\"},{\"_id\":\"5fdc726990c42013dc199fd3\",\"type\":0,\"cadencyDeputy\":\"5ea83ea5f75d4e47cc83a0dc\"},{\"_id\":\"5fdc726990c42013dc199fdc\",\"type\":0,\"cadencyDeputy\":\"5ea83ea5f75d4e47cc83a155\"},{\"_id\":\"5fdc726990c42013dc199fef\",\"type\":3,\"cadencyDeputy\":\"5ea83ea5f75d4e47cc839eb4\"}],\"votingType\":5,\"parliamentClubVotingNumbers\":[{\"_id\":\"5fdc726990c42013dc19a001\",\"absent\":1,\"inFavor\":0,\"hold\":1,\"against\":232,\"totalDeputies\":234,\"actualVoted\":233,\"parliamentClub\":\"5fabd23f9889252626a19239\"},{\"_id\":\"5fdc726990c42013dc19a002\",\"absent\":0,\"inFavor\":133,\"hold\":0,\"against\":1,\"totalDeputies\":134,\"actualVoted\":134,\"parliamentClub\":\"5fabd23f9889252626a19240\"},{\"_id\":\"5fdc726990c42013dc19a003\",\"absent\":0,\"inFavor\":48,\"hold\":0,\"against\":0,\"totalDeputies\":48,\"actualVoted\":48,\"parliamentClub\":\"5fabd23f9889252626a1923a\"},{\"_id\":\"5fdc726990c42013dc19a004\",\"absent\":1,\"inFavor\":23,\"hold\":0,\"against\":0,\"totalDeputies\":24,\"actualVoted\":23,\"parliamentClub\":\"5fc2e5db9889252626ba19cb\"},{\"_id\":\"5fdc726990c42013dc19a005\",\"absent\":1,\"inFavor\":10,\"hold\":0,\"against\":0,\"totalDeputies\":11,\"actualVoted\":10,\"parliamentClub\":\"5fabd23f9889252626a1923b\"},{\"_id\":\"5fdc726990c42013dc19a006\",\"absent\":7,\"inFavor\":2,\"hold\":0,\"against\":0,\"totalDeputies\":9,\"actualVoted\":2,\"parliamentClub\":\"5fabd23f9889252626a1923f\"}],\"absoluteMajority\":null,\"qualifyingMajority\":231,\"__v\":0,\"id\":\"5fdc726990c42013dc199e34\"}";
}