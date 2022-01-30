class ParliamentMeetingCacheError implements Exception {
  final String parliamentMeetingId;
  ParliamentMeetingCacheError(this.parliamentMeetingId);

  @override
  String toString() {
    return "ParliamentMeetingCacheError: There was an error while fetching parliament meeting with id: " + parliamentMeetingId;
  }
}

class ParliamentClubsCacheError implements Exception {
  @override
  String toString() {
    return "ParliamentClubsCacheError: There was an error while fetching clubs";
  }
}

class DeputiesCacheError implements Exception {
  @override
  String toString() {
    return "DeputiesCacheError: There was an error while fetching deputies";
  }
}