class SpeechesEasyFilter {
  SpeechesEasyFilter._();

  factory SpeechesEasyFilter.subscribed() = SpeechesSubscribedFilter;
  factory SpeechesEasyFilter.parliamentClub(String id) = SpeechesParliamentClubFilter;
  factory SpeechesEasyFilter.seen() = SpeechSeenFilter;
  factory SpeechesEasyFilter.notSeen() = SpeechNotSeenFilter;
}

class SpeechesSubscribedFilter extends SpeechesEasyFilter {
  SpeechesSubscribedFilter(): super._();
}

class SpeechesParliamentClubFilter extends SpeechesEasyFilter {
  final String id;

  SpeechesParliamentClubFilter(this.id): super._();
}

class SpeechSeenFilter extends SpeechesEasyFilter {
  SpeechSeenFilter() : super._();
}

class SpeechNotSeenFilter extends SpeechesEasyFilter {
  SpeechNotSeenFilter() : super._();
}