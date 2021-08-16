import 'package:project_athens/athens_core/models/timeline_model.dart';
import 'package:project_athens/athens_core/models/voting_model.dart';

class VotesGrouper {
  List<TimelineModel> groupVotes(List<TimelineModel> models) {
    final groupedVotes = Map<int, List<VotingModel>>();

    List<TimelineModel> votesToGroup = models
        .where(
            (element) => element is VotingModel && element.orderPoint != null)
        .toList();
    votesToGroup.forEach((element) {
      VotingModel voting = element as VotingModel;
      List<VotingModel> group = groupedVotes[voting.orderPoint] ?? List.empty();
      group.add(voting);
      groupedVotes[voting.orderPoint!] = group;
    });

    final newList = models
        .where((element) =>
    !(element is VotingModel && element.orderPoint != null))
        .toList();

    groupedVotes.values.forEach((group) {
      newList.add(group.createGroupedVotingModel());
    });

    return newList;
  }
}