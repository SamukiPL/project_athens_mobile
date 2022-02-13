import 'package:flutter/material.dart';

class LinearVoteDistributionSegment {
  final int votes;
  final String label;
  final Color color;
  final bool isBeingUsed;

  LinearVoteDistributionSegment(this.votes, this.label, this.color, this.isBeingUsed);
}
