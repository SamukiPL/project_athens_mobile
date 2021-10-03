class DeputiesEasyFilter {
  DeputiesEasyFilter._();

  factory DeputiesEasyFilter.subscribed() = Subscribed;
  factory DeputiesEasyFilter.parliamentClub(String id) = ParliamentClub;
}

class Subscribed extends DeputiesEasyFilter {
  Subscribed(): super._();
}

class ParliamentClub extends DeputiesEasyFilter {
  final String id;

  ParliamentClub(this.id): super._();
}
