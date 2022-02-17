class SpeechesEasyFilter {
  SpeechesEasyFilter._();

  factory SpeechesEasyFilter.subscribed() = SpeechesSubscribedFilter;
  factory SpeechesEasyFilter.parliamentClub(String id) = SpeechesParliamentClubFilter;
  factory SpeechesEasyFilter.seen() = SeenFilter;
  factory SpeechesEasyFilter.notSeen() = NotSeenFilter;
}

class SpeechesSubscribedFilter extends SpeechesEasyFilter {
  SpeechesSubscribedFilter(): super._();
}

class SpeechesParliamentClubFilter extends SpeechesEasyFilter {
  final String id;

  SpeechesParliamentClubFilter(this.id): super._();
}

class SeenFilter extends SpeechesEasyFilter {
  SeenFilter() : super._();
}

class NotSeenFilter extends SpeechesEasyFilter {
  NotSeenFilter() : super._();
}