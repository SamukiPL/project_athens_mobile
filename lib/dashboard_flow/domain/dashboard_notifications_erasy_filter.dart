class DashboardNotificationsEasyFilter {
  DashboardNotificationsEasyFilter._();

  factory DashboardNotificationsEasyFilter.speechesEasyFilter() = SpeechesEasyFilter;
  factory DashboardNotificationsEasyFilter.votesEasyFilter() = VotesEasyFilter;
  factory DashboardNotificationsEasyFilter.notReadEasyFilter() = NotReadEasyFilter;
}

class SpeechesEasyFilter extends DashboardNotificationsEasyFilter {
  SpeechesEasyFilter(): super._();
}

class VotesEasyFilter extends DashboardNotificationsEasyFilter {
  VotesEasyFilter(): super._();
}

class NotReadEasyFilter extends DashboardNotificationsEasyFilter {
  NotReadEasyFilter(): super._();
}