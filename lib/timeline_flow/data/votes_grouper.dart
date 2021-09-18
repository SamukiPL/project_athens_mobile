import 'package:project_athens/athens_core/data/vote/vote_slim_model.dart';
import 'package:project_athens/athens_core/models/timeline_model.dart';
import 'package:project_athens/athens_core/models/timeline_voting_model.dart';

class VotesGrouper {
  List<TimelineModel> groupVotes(List<TimelineModel> models) {
    final groupedVotes = Map<int, List<TimelineVotingModel>>();

    List<TimelineModel> votesToGroup = models
        .where((element) =>
            element is TimelineVotingModel && element.orderPoint != null)
        .toList();
    votesToGroup.forEach((element) {
      TimelineVotingModel voting = element as TimelineVotingModel;
      List<TimelineVotingModel> group =
          groupedVotes[voting.orderPoint] ?? List.empty();
      group.add(voting);
      groupedVotes[voting.orderPoint!] = group;
    });

    final newList = models
        .where((element) =>
            !(element is TimelineVotingModel && element.orderPoint != null))
        .toList();

    groupedVotes.values.forEach((group) {
      newList.add(group.createGroupedVotingModel());
    });

    return newList;
  }
}
