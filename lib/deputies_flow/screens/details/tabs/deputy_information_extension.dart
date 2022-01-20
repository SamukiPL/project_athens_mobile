import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/presentation/simple_horizontal_table/simple_horizontal_table_cell.dart';
import 'package:project_athens/deputies_utils/domain/deputy_full.dart';

extension DeputyFullExtension on DeputyFull {

  List<SimpleHorizontalTableCell> getBriefInfoTableCells(AppLocalizations localizations) {
    final born = cv.born;
    final bornDate = born.contains(',') ? born.substring(0, born.indexOf(',')) : born;

    return [
      SimpleHorizontalTableCell(lowerText: bornDate, upperText: localizations.getText().deputiesBirthDate()),
      SimpleHorizontalTableCell(lowerText: cv.education ?? localizations.getText().universalNoDataNoInformation(), upperText: localizations.getText().deputiesEducation()),
      SimpleHorizontalTableCell(lowerText: cv.profession ?? localizations.getText().universalNoDataNoInformation(), upperText: localizations.getText().deputiesProfession())
    ].toList();
  }

  String getFinishedSchools(AppLocalizations localizations) {
    return cv.finishedSchools?.trim() ?? localizations.getText().universalNoDataNoInformation();
  }

  String getParliamentExperience(AppLocalizations localizations) {
    return cv.parliamentExperience.trim() ?? localizations.getText().universalNoDataNoInformation();
  }

  DeputyCv getDeputyCV() {
    return cv;
  }

  String getDeputyId() {
    return id;
  }

  Statistics getStatistics() {
    return statistics;
  }

  List<SimpleHorizontalTableCell> getStatisticsHorizontalTableCells(AppLocalizations localizations) {
    final stats = statistics;

    final voteAccuracy = stats.clubVoteAccuracy;
    voteAccuracy.sort((a, b) => a.compatibleVotes > b.compatibleVotes ? -1 : 1);
    String highestAccuracyText;

    if (voteAccuracy.length > 0) {
      final highestAccuracyClub = voteAccuracy[0];
      highestAccuracyText = highestAccuracyClub.parliamentClub!.shortName;
    } else {
      highestAccuracyText = localizations.getText().deputiesNoHighestAccuracy();
    }


    return [
      SimpleHorizontalTableCell(
          lowerText: stats.speechesCount.toString(),
          // icon: Icons.record_voice_over,
          upperText: localizations.getText().deputiesSpeechCounter()),
      SimpleHorizontalTableCell(
          lowerText: stats.voteAbsencyCount.toString(),
          // icon: MdiIcons.accountOff,
          upperText: localizations.getText().deputiesVoteAbsency()),
      SimpleHorizontalTableCell(
          lowerText: highestAccuracyText,
          // icon: Icons.gps_fixed,
          upperText: localizations.getText().deputiesMostAccuracy())
    ].toList();
  }
}