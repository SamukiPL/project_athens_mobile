class DeputySpeechesEasyFilter {
  DeputySpeechesEasyFilter._();

  factory DeputySpeechesEasyFilter.seen() = DeputySpeechSeenFilter;
  factory DeputySpeechesEasyFilter.notSeen() = DeputySpeechNotSeenFilter;
}

class DeputySpeechSeenFilter extends DeputySpeechesEasyFilter {
  DeputySpeechSeenFilter() : super._();
}

class DeputySpeechNotSeenFilter extends DeputySpeechesEasyFilter {
  DeputySpeechNotSeenFilter() : super._();
}
