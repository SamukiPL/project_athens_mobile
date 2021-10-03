enum VoteAccuracyAlignment {
  ALIGNED,
  NOT_ALIGNED
}

extension VoteAccuracyAlignmentToString on VoteAccuracyAlignment {
  String toStringValue() {
    switch(this) {
      case VoteAccuracyAlignment.NOT_ALIGNED:
        return "NOT_ALIGNED";
      case VoteAccuracyAlignment.ALIGNED:
        return "ALIGNED";
    }
  }
}
