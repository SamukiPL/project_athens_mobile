
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/models/voting_model.dart';

class LinearVoteDistributionSegment {
  final int votes;
  final String label;
  final Color color;
  final bool isBeingUsed;

  LinearVoteDistributionSegment(this.votes, this.label, this.color, this.isBeingUsed);
}