import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/presentation/base_blocs/base_bloc.dart';
import 'package:project_athens/athens_core/presentation/simple_horizontal_table/simple_horizontal_table_cell.dart';
import 'package:project_athens/deputies_utils/cache/deputies_cache.dart';
import 'package:project_athens/deputies_utils/domain/deputy_full.dart';

class DeputyInformationDetailsTabBloc extends BaseBloc {
  final DeputyFull _deputyFull;
  final DeputiesCache _deputiesCache;

  DeputyInformationDetailsTabBloc(this._deputyFull, this._deputiesCache);

  List<SimpleHorizontalTableCell> getBriefInfoTableCells(AppLocalizations localizations) {
    final born = _deputyFull.cv.born;
    final bornDate = born.contains(',') ? born.substring(0, born.indexOf(',')) : born;

    return [
      SimpleHorizontalTableCell(lowerText: bornDate, upperText: localizations.getText().deputiesBirthDate()),
      SimpleHorizontalTableCell(lowerText: _deputyFull.cv.education, upperText: localizations.getText().deputiesEducation()),
      SimpleHorizontalTableCell(lowerText: _deputyFull.cv.profession, upperText: localizations.getText().deputiesProfession())
    ].toList();
  }

  String getFinishedSchools() {
    // return deputyFull.cv.finishedSchools.split(',').map((e) => e.trim()).toList();
    return _deputyFull.cv.finishedSchools.trim();
  }

  DeputyCv getDeputyCV() {
    return _deputyFull.cv;
  }

  String getDeputyId() {
    return _deputyFull.id;
  }

  // String getParliamentExperience() {
  //   return deputyFull.
  // }

  Statistics getStatistics() {
    return _deputyFull.statistics;
  }

  List<SimpleHorizontalTableCell> getStatisticsHorizontalTableCells(AppLocalizations localizations) {
    final stats = _deputyFull.statistics;

    final voteAccuracy = stats.clubVoteAccuracy;
    voteAccuracy.sort((a, b) => a.compatibleVotes > b.compatibleVotes ? -1 : 1);
    String highestAccuracyText;

    if (voteAccuracy.length > 0) {
      final highestAccuracyClub = voteAccuracy[0];
      highestAccuracyText = highestAccuracyClub.parliamentClub.shortName;
    } else {
      highestAccuracyText = localizations.getText().deputiesNoHighestAccuracy();
    }


    return [
      SimpleHorizontalTableCell(
          lowerText: stats.speechesCount.toString(),
          // icon: Icons.record_voice_over,
          upperText: 'Licznik przemówień'),
      SimpleHorizontalTableCell(
          lowerText: stats.voteAbsencyCount.toString(),
          // icon: MdiIcons.accountOff,
          upperText: 'Nieobecność na głosowaniach'),
      SimpleHorizontalTableCell(
          lowerText: highestAccuracyText,
          // icon: Icons.gps_fixed,
          upperText: 'Największa zgodność')
    ].toList();
  }
}