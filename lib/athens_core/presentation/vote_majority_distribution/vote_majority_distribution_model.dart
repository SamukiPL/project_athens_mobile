import 'package:project_athens/athens_core/models/voting_model.dart';

class VoteMajorityDistributionModel {
  final String? img;
  final VoteType type;
  final String alt;
  final bool isDeputy;
  final bool? hidden;

  VoteMajorityDistributionModel({required this.img, required this.type, required this.alt, this.isDeputy = false, this.hidden = false});
}
