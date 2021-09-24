import 'package:project_athens/deputies_flow/domain/vote_accuracy_alignment_enum.dart';

String voteAccuracyEnumToString(VoteAccuracyAlignment accuracy) {
  switch(accuracy) {
    case VoteAccuracyAlignment.NOT_ALIGNED:
      return "NOT_ALIGNED";
    case VoteAccuracyAlignment.ALIGNED:
      return "ALIGNED";
  }
}
