class SpeechesEasyFilter {
  SpeechesEasyFilter._();

  factory SpeechesEasyFilter.subscribed() = SpeechesSubscribedFilter;
  factory SpeechesEasyFilter.parliamentClub(String id) = SpeechesParliamentClubFilter;
}

class SpeechesSubscribedFilter extends SpeechesEasyFilter {
  SpeechesSubscribedFilter(): super._();
}

class SpeechesParliamentClubFilter extends SpeechesEasyFilter {
  final String id;

  SpeechesParliamentClubFilter(this.id): super._();
}
