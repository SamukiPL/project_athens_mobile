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