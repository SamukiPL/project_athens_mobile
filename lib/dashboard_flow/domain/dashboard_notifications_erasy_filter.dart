class DashboardNotificationsEasyFilter {
  DashboardNotificationsEasyFilter._();

  factory DashboardNotificationsEasyFilter.SpeechesEasyFilter() = SpeechesEasyFilter;
  factory DashboardNotificationsEasyFilter.VotesEasyFilter() = VotesEasyFilter;
  factory DashboardNotificationsEasyFilter.NotReadEasyFilter() = NotReadEasyFilter;
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