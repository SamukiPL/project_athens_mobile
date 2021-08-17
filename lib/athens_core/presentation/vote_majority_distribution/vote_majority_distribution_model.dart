import 'package:project_athens/athens_core/models/voting_model.dart';

class VoteMajorityDistributionModel {
  final String img;
  final VoteType type;
  final String alt;
  final bool isDeputy;

  VoteMajorityDistributionModel(this.img, this.type, this.alt, this.isDeputy);
}