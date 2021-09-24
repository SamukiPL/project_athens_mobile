import 'package:collection/collection.dart';
import 'package:project_athens/athens_core/data/vote/vote_slim_model.dart';
import 'package:project_athens/athens_core/presentation/vote_majority_distribution/vote_majority_distribution_model.dart';

List<VoteMajorityDistributionModel> voteMajorityDistrinutionFromVoteSlim(List<VoteSlimClubMajority> clubsMajority, List<VoteSlimDeputyVoteType> deputiesVote, bool showInaccuracyOnly) {
  bool shouldHide(VoteSlimDeputyVoteType deputy) {
    // deputies can change being member of club, but server will return us votes
    final clubOfDeputyAtThatTime = clubsMajority.firstWhereOrNull((element) => element.deputyCardNumbers.contains(deputy.subscribedDeputy.cardId));

    if (clubOfDeputyAtThatTime != null) {
      return clubOfDeputyAtThatTime.voteMajority == deputy.voteType;
    } else {
      // in that case some data may be incomplete or sejm.gov.pl fucked up something once again...
      // so it's better to show deputy vote
      return false;
    }
  }

  final List<VoteMajorityDistributionModel> result = clubsMajority.map((e) => VoteMajorityDistributionModel(
      img: e.parliamentClubModel.imageSrc,
      type: e.voteMajority,
      alt: e.parliamentClubModel.shortName,
      isDeputy: false,
      hidden: false
  )).toList();

  final List<VoteMajorityDistributionModel> deputyModels = deputiesVote.map((e) => VoteMajorityDistributionModel(
      img: e.subscribedDeputy.thumbnailUrl ?? "",
      type: e.voteType,
      alt: e.subscribedDeputy.name,
      isDeputy: true,
      hidden: showInaccuracyOnly ? shouldHide(e) : false
    )
  ).toList();

  result.addAll(deputyModels);

  return result;
}